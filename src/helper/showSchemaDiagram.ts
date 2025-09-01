import type { Connection } from 'oracledb';
import { dbConfig } from '../config/database';
import * as fs from 'fs';
import path from 'path';

export async function showSchemaDiagram(connection: Connection, output?: string): Promise<void> {
  // First, get all tables and their columns
  const tablesResult = await connection.execute(
    `SELECT t.table_name, c.column_name, c.data_type
     FROM all_tables t
     JOIN all_tab_columns c ON t.table_name = c.table_name 
     WHERE t.owner = :owner 
     AND c.owner = :owner
     ORDER BY t.table_name, c.column_id`,
    { owner: (dbConfig.user || '').toUpperCase() }
  );

  // Then get foreign key relationships
  const relationsResult = await connection.execute(
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

  // Generate Mermaid diagram content starting with all tables
  let mermaidContent = 'erDiagram\n';
  
  // Track field types for consistency
  const fieldTypeMap: Record<string, string> = {};
  // Add all tables with their columns
  if (tablesResult.rows) {
    let currentTable = '';
    let tableContent = '';
    let tableCount = 0;
    let totalTables = new Set(tablesResult.rows.map((row: any) => row[0])).size;

    console.log(`Found ${totalTables} tables in the schema\n`);

    tablesResult.rows.forEach((row: any) => {
  // Rename REFERENCES table to REFERENCE_DATA
  let tableName = row[0];
  let columnName = row[1];
  let dataType = row[2];

  if (tableName.toUpperCase() === 'REFERENCES') tableName = 'REFERENCE_DATA';

  // Perbaiki typo field: CRAETED_DATE -> CREATED_DATE
  if (columnName.toUpperCase() === 'CRAETED_DATE') columnName = 'CREATED_DATE';

      // Field type mapping
      let shortDataType = dataType.toUpperCase();
      if (shortDataType.includes('NUMBER')) shortDataType = 'int';
      else if (shortDataType.includes('FLOAT')) shortDataType = 'float';
      else if (shortDataType.includes('DATE')) shortDataType = 'date';
      else if (shortDataType.includes('TIMESTAMP')) shortDataType = 'date';
      else if (shortDataType.includes('CHAR')) shortDataType = 'string';
      else if (shortDataType.includes('VARCHAR')) shortDataType = 'string';
      else if (shortDataType.includes('CLOB') || shortDataType.includes('BLOB')) shortDataType = 'string';
      else if (shortDataType.includes('NCHAR') || shortDataType.includes('NVARCHAR')) shortDataType = 'string';
      else if (shortDataType.includes('BOOLEAN')) shortDataType = 'boolean';
      else shortDataType = 'string';

      // Field khusus: BUKTI_TGL selalu date, BUKTI_FISIK_DOKUMEN selalu string
      if (columnName.toUpperCase() === 'BUKTI_TGL') shortDataType = 'date';
      if (columnName.toUpperCase() === 'BUKTI_FISIK_DOKUMEN') shortDataType = 'string';

      // Konsistensi tipe field antar tabel
      if (fieldTypeMap[columnName]) {
        shortDataType = fieldTypeMap[columnName];
      } else {
        fieldTypeMap[columnName] = shortDataType;
      }

      // Hanya tipe valid Mermaid
      if (!['string', 'int', 'float', 'boolean', 'date'].includes(shortDataType)) {
        shortDataType = 'string';
        fieldTypeMap[columnName] = 'string';
      }

      if (currentTable !== tableName) {
        // Close previous table if exists
        if (currentTable !== '') {
          mermaidContent += `    ${currentTable} {\n${tableContent}    }\n`;
        }
        // Start new table
        currentTable = tableName;
        tableContent = '';
        tableCount++;
        process.stdout.write(`\rProcessing tables... ${tableCount}/${totalTables}`);
      }

      tableContent += `        ${shortDataType} ${columnName}\n`;
    });

    // Close the last table
    if (currentTable !== '') {
      mermaidContent += `    ${currentTable} {\n${tableContent}    }\n`;
    }
  }

  // Add relationships between tables
  if (relationsResult.rows && relationsResult.rows.length > 0) {
    // Track processed relationships to avoid duplicates (parent-child only)
    const processedRelations = new Set<string>();
    relationsResult.rows.forEach((row: any) => {
      let childTable = row[0];
      let parentTable = row[1];
      // Rename REFERENCES table to REFERENCE_DATA in relations
      if (childTable.toUpperCase() === 'REFERENCES') childTable = 'REFERENCE_DATA';
      if (parentTable.toUpperCase() === 'REFERENCES') parentTable = 'REFERENCE_DATA';
      // Only one relasi per pasangan parent-child
      const relationKey = `${parentTable}-${childTable}`;
      if (!processedRelations.has(relationKey)) {
        mermaidContent += `    ${parentTable} ||--o{ ${childTable} : "has"\n`;
        processedRelations.add(relationKey);
      }
    });
  } else {
    mermaidContent += '    %% No relationships found\n';
  }

  // Create output directory if doesn't exist
  const outputDir = 'schema-output';
  if (!fs.existsSync(outputDir)) {
    fs.mkdirSync(outputDir);
  }

  if (output === 'file') {
    // Save as mermaid file
    const filePath = path.join(outputDir, 'schema.mermaid');
    fs.writeFileSync(filePath, mermaidContent);
    console.log(`Schema saved to ${filePath}`);
  } else {
    // Display in console if no output specified
    console.log('\nSchema Diagram:');
    console.log('```mermaid');
    console.log(mermaidContent);
    console.log('```');
  }
}
