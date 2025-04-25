import type { Connection } from 'oracledb';
import { dbConfig } from '../config/database';

export async function showForeignKeys(connection: Connection, tableName?: string): Promise<void> {
  const query = `
    SELECT 
      a.table_name child_table,
      a.column_name child_column,
      a.constraint_name,
      c.table_name parent_table,
      c_cols.column_name parent_column
    FROM 
      all_cons_columns a
      JOIN all_constraints c_pk 
        ON a.owner = c_pk.owner 
        AND a.constraint_name = c_pk.constraint_name
      JOIN all_constraints c 
        ON c_pk.owner = c.owner 
        AND c_pk.r_constraint_name = c.constraint_name
      JOIN all_cons_columns c_cols
        ON c.owner = c_cols.owner
        AND c.constraint_name = c_cols.constraint_name
    WHERE 
      c_pk.owner = :1
      AND c_pk.constraint_type = 'R'
      ${tableName ? "AND (a.table_name = :2 OR c.table_name = :2)" : ""}
    ORDER BY 
      a.table_name,
      a.column_name`;

  const params = tableName ? [(dbConfig.user || '').toUpperCase(), tableName.toUpperCase(), tableName.toUpperCase()] : [(dbConfig.user || '').toUpperCase()];
  const result = await connection.execute(query, params);

  console.log('\nForeign Key Relationships:');
  console.log('-'.repeat(120));
  console.log('SOURCE TABLE'.padEnd(20) + 'FOREIGN KEY'.padEnd(20) + 'TARGET TABLE'.padEnd(20) + 'TARGET FIELD'.padEnd(20) + 'CONSTRAINT NAME'.padEnd(40));
  console.log('-'.repeat(120));

  if (!result.rows || result.rows.length === 0) {
    console.log('No foreign keys found'.padEnd(120));
  } else {
    result.rows.forEach((row: any) => {
      console.log(
        `${row[0]}`.padEnd(20) + 
        `${row[1]}`.padEnd(20) + 
        `${row[3]}`.padEnd(20) + 
        `${row[4]}`.padEnd(20) +
        `${row[2]}`.padEnd(40)
      );
    });
  }
  console.log('-'.repeat(120));
}
