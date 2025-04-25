import type { Connection } from 'oracledb';
import { dbConfig } from '../config/database';

export async function showSchemaDiagram(connection: Connection): Promise<void> {
  // Query to get foreign key relationships
  const result = await connection.execute(
    `SELECT 
      a.table_name AS child_table,
      c.table_name AS parent_table,
      acc.column_name AS child_column,
      pcc.column_name AS parent_column
    FROM all_constraints a
    JOIN all_constraints c ON a.r_constraint_name = c.constraint_name
    JOIN all_cons_columns acc ON a.constraint_name = acc.constraint_name
    JOIN all_cons_columns pcc ON c.constraint_name = pcc.constraint_name
    WHERE a.constraint_type = 'R'
    AND a.owner = :owner
    AND c.owner = :owner
    AND acc.owner = :owner
    AND pcc.owner = :owner
    ORDER BY a.table_name, c.table_name`,
    { owner: (dbConfig.user || '').toUpperCase() }
  );

  // Start building Mermaid diagram
  console.log('\nSchema Diagram:');
  console.log('```mermaid');
  console.log('erDiagram');

  if (result.rows && result.rows.length > 0) {
    // Track processed relationships to avoid duplicates
    const processedRelations = new Set<string>();

    result.rows.forEach((row: any) => {
      const childTable = row[0];
      const parentTable = row[1];
      const childColumn = row[2];
      const parentColumn = row[3];

      // Create a unique key for this relationship
      const relationKey = `${childTable}-${parentTable}-${childColumn}-${parentColumn}`;

      if (!processedRelations.has(relationKey)) {
        // Add relationship to diagram using Mermaid syntax
        console.log(`    ${parentTable} ||--o{ ${childTable} : "has"`)
        processedRelations.add(relationKey);
      }
    });
  } else {
    console.log('    %% No relationships found');
  }

  console.log('```');
}
