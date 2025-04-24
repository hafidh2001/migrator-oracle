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
