import oracledb from 'oracledb';
import type { Connection, Result } from 'oracledb';

interface DBMSOutput extends Result<any> {
  outBinds?: {
    ln: string | null;
    st: number;
  };
}
import { promises as fs } from 'fs';

export async function runQuery(connection: Connection, queryPath: string): Promise<void> {
  try {
    // Enable DBMS_OUTPUT
    await connection.execute(`BEGIN DBMS_OUTPUT.ENABLE(NULL); END;`);
    
    // Read the SQL file
    const sqlContent = await fs.readFile(queryPath, 'utf8');
    
    // Split the content by SQL delimiter (/) to handle multiple statements
    const queries = sqlContent.split('/').filter(q => q.trim());
    
    console.log(`\nExecuting SQL from: ${queryPath}`);
    console.log('-'.repeat(50));
    
    // Execute each query
    for (const query of queries) {
      try {
        await connection.execute(query);
        
        // Get DBMS_OUTPUT
        let output: DBMSOutput;
        do {
          output = await connection.execute(
            `BEGIN DBMS_OUTPUT.GET_LINE(:ln, :st); END;`,
            {
              ln: { dir: oracledb.BIND_OUT, type: oracledb.STRING, maxSize: 32767 },
              st: { dir: oracledb.BIND_OUT, type: oracledb.NUMBER }
            }
          );
          if (output.outBinds?.st === 0 && output.outBinds.ln !== null) {
            console.log(output.outBinds.ln);
          }
        } while (output.outBinds?.st === 0 && output.outBinds.ln !== null);
        
      } catch (error: any) {
        console.error(`❌ Error executing query: ${error.message}`);
        throw error;
      }
    }
    
    console.log('-'.repeat(50));
    console.log('All queries completed successfully');
    
  } catch (error: any) {
    if (error.code === 'ENOENT') {
      console.error(`❌ File not found: ${queryPath}`);
    } else {
      console.error(`❌ Error: ${error.message}`);
    }
    throw error;
  }
}
