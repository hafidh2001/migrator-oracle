import oracledb from 'oracledb';
import type { Connection } from 'oracledb';
import { dbConfig } from '../config/database';

export async function initializeConnection(): Promise<Connection> {
  // Enable auto-commit
  oracledb.autoCommit = true;

  // Create connection
  const connection = await oracledb.getConnection(dbConfig);

  // Display connection info
  console.log('\nConnection details:');
  console.log('------------------');
  console.log(`Host: ${dbConfig.connectString}`);
  console.log(`Database: ORCLCDB`);
  console.log(`User: ${dbConfig.user || ''}`);
  
  console.log('\n🟢 Database connection successful!');

  return connection;
}

export async function closeConnection(connection: Connection): Promise<void> {
  await connection.close();
  console.log('Connection closed');
}
