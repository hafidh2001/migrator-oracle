import type { Connection } from 'oracledb';
import { dbConfig } from '../config/database';

export async function showTables(connection: Connection): Promise<void> {
  const result = await connection.execute(
    `SELECT owner, table_name 
     FROM all_tables 
     WHERE owner = :1
     ORDER BY table_name`,
    [(dbConfig.user || '').toUpperCase()]
  );
  
  console.log('\nAvailable tables:');
  console.log('-'.repeat(50));
  console.log('SCHEMA'.padEnd(20) + 'TABLE NAME'.padEnd(30));
  console.log('-'.repeat(50));
  if (result.rows && result.rows.length > 0) {
    result.rows.forEach((row: any) => {
      console.log(`${row[0]}`.padEnd(20) + `${row[1]}`.padEnd(30));
    });
  } else {
    console.log('No tables found');
  }
  console.log('-'.repeat(50));
}

export async function showTableStructure(connection: Connection, tableName: string): Promise<void> {
  const result = await connection.execute(
    `SELECT column_name, data_type, data_length, nullable
     FROM all_tab_columns
     WHERE owner = :1
     AND table_name = :2
     ORDER BY column_id`,
    [(dbConfig.user || '').toUpperCase(), tableName.toUpperCase()]
  );
  
  console.log(`\nStructure for table ${tableName}:`);
  console.log('-'.repeat(90));
  console.log(
    'COLUMN NAME'.padEnd(30) + 
    'DATA TYPE'.padEnd(20) + 
    'LENGTH'.padEnd(20) + 
    'NULLABLE'.padEnd(20)
  );
  console.log('-'.repeat(90));
  if (result.rows && result.rows.length > 0) {
    result.rows.forEach((row: any) => {
      console.log(
        `${row[0]}`.padEnd(30) + 
        `${row[1]}`.padEnd(20) + 
        `${row[2]}`.toString().padEnd(20) + 
        `${row[3] === 'Y' ? 'NULL' : 'NOT NULL'}`.padEnd(20)
      );
    });
  } else {
    console.log('Table not found'.padEnd(90));
  }
  console.log('-'.repeat(90));
}

export async function showTableRelations(connection: Connection, tableName?: string): Promise<void> {
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

  if (!result.rows || result.rows.length === 0) {
    console.log('\nNo relationships found.');
    return;
  }

  console.log('\nTable Relationships:');
  console.log('-'.repeat(100));
  console.log('SOURCE TABLE'.padEnd(20) + 'FOREIGN KEY'.padEnd(20) + 'TARGET TABLE'.padEnd(20) + 'TARGET FIELD'.padEnd(20));
  console.log('-'.repeat(100));
  
  result.rows.forEach((row: any) => {
    console.log(
      `${row[0]}`.padEnd(20) + 
      `${row[1]}`.padEnd(20) + 
      `${row[3]}`.padEnd(20) + 
      `${row[4]}`.padEnd(20)
    );
  });
  console.log('-'.repeat(100));
}
