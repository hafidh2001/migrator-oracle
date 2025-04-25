import { readdirSync, existsSync } from 'fs';
import { extname } from 'path';
import type { Connection } from 'oracledb';
import { dbConfig } from '../config/database';

export async function compareFilesWithTables(connection: Connection, backupDir: string): Promise<void> {
  if (!existsSync(backupDir)) {
    console.error(`❌ Directory not found: ${backupDir}`);
    return;
  }

  const files = readdirSync(backupDir);
  const filenames = files.map(f => {
    const ext = extname(f);
    return f.slice(0, -ext.length).toUpperCase();
  });

  const result = await connection.execute(
    `SELECT table_name FROM all_tables WHERE owner = :1`,
    [(dbConfig.user || '').toUpperCase()]
  );

  const tables = (result.rows || []).map((row) => (row as unknown[])[0]);

  console.log('\nFILENAME'.padEnd(30) + 'TABLENAME'.padEnd(30) + 'EXIST');
  console.log('-'.repeat(80));
  files.forEach(file => {
    const ext = extname(file);
    const base = file.slice(0, -ext.length).toUpperCase();
    const exist = tables.includes(base);
    const tableName = exist ? base : '';
    console.log(file.padEnd(30) + tableName.padEnd(30) + (exist ? '✅' : '❌'));
  });
  console.log('-'.repeat(80));
}
