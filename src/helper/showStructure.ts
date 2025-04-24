import type { Connection } from 'oracledb';
import { dbConfig } from '../config/database';

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
