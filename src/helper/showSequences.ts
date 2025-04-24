import type { Connection } from 'oracledb';
import { dbConfig } from '../config/database';

export async function showSequences(connection: Connection): Promise<void> {
  const result = await connection.execute(
    `SELECT 
       sequence_owner,
       sequence_name,
       min_value,
       max_value,
       increment_by,
       last_number,
       cache_size
     FROM all_sequences 
     WHERE sequence_owner = :1
     ORDER BY sequence_name`,
    [(dbConfig.user || '').toUpperCase()]
  );
  
  console.log('\nAvailable Sequences:');
  console.log('-'.repeat(120));
  console.log(
    'SEQUENCE NAME'.padEnd(30) + 
    'MIN VALUE'.padEnd(15) + 
    'MAX VALUE'.padEnd(15) + 
    'INCREMENT'.padEnd(15) + 
    'LAST NUMBER'.padEnd(15) + 
    'CACHE'.padEnd(10)
  );
  console.log('-'.repeat(120));

  if (result.rows && result.rows.length > 0) {
    result.rows.forEach((row: any) => {
      console.log(
        `${row[1]}`.padEnd(30) + 
        `${row[2]}`.padEnd(15) + 
        `${row[3]}`.padEnd(15) + 
        `${row[4]}`.padEnd(15) + 
        `${row[5]}`.padEnd(15) + 
        `${row[6]}`.padEnd(10)
      );
    });
  } else {
    console.log('No sequences found');
  }
  console.log('-'.repeat(120));
}
