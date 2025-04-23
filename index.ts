import oracledb from 'oracledb';
import { dbConfig } from './src/config/database';

interface CommandArgs {
  show?: string;
  table?: string;
}

function parseArgs(): CommandArgs {
  const args = process.argv.slice(2);
  const result: CommandArgs = {};
  
  args.forEach(arg => {
    const [key, value] = arg.replace('--', '').split('=');
    result[key as keyof CommandArgs] = value;
  });
  
  return result;
}

async function showTables(connection: oracledb.Connection) {
  const result = await connection.execute(
    `SELECT owner, table_name 
     FROM all_tables 
     WHERE owner = :1
     ORDER BY table_name`,
    [(dbConfig.user || '').toUpperCase()]
  );
  
  console.log('\nAvailable tables:');
  console.log('----------------');
  if (result.rows && result.rows.length > 0) {
    result.rows.forEach((row: any) => {
      console.log(`${row[0]}.${row[1]}`);
    });
  } else {
    console.log('No tables found');
  }
}

async function showTableStructure(connection: oracledb.Connection, tableName: string) {
  const result = await connection.execute(
    `SELECT column_name, data_type, data_length, nullable
     FROM all_tab_columns
     WHERE owner = :1
     AND table_name = :2
     ORDER BY column_id`,
    [(dbConfig.user || '').toUpperCase(), tableName.toUpperCase()]
  );
  
  console.log(`\nStructure for table ${tableName}:`);
  console.log('-'.repeat(85));
  console.log('COLUMN NAME'.padEnd(30) + 'DATA TYPE'.padEnd(20) + 'LENGTH'.padEnd(15) + 'NULLABLE');
  console.log('-'.repeat(85));
  if (result.rows && result.rows.length > 0) {
    result.rows.forEach((row: any) => {
      const columnName = row[0].padEnd(30);
      const dataType = row[1].padEnd(20);
      const length = row[2].toString().padEnd(15);
      const nullable = row[3] === 'Y' ? 'NULL' : 'NOT NULL';
      console.log(`${columnName}${dataType}${length}${nullable}`);
    });
  } else {
    console.log('Table not found');
  }
}

async function main() {
  const args = parseArgs();
  try {
    // Enable auto-commit
    oracledb.autoCommit = true;

    // Create connection
    const connection = await oracledb.getConnection(dbConfig);

    console.log('\nConnection details:');
    console.log('------------------');
    console.log(`Host: ${dbConfig.connectString}`);
    console.log(`Database: ORCLCDB`);
    console.log(`User: ${dbConfig.user || ''}`);
    
    console.log('\n🟢 Database connection successful!');
    
    console.log('\nAvailable commands:');
    console.log('------------------');
    console.log('bun run index.ts --show=tables');
    console.log('bun run index.ts --show=structure --table=TABLE_NAME');
    
    if (!args.show) {
      await connection.close();
      return;
    }

    if (args.show === 'tables') {
      await showTables(connection);
    } else if (args.show === 'structure' && args.table) {
      await showTableStructure(connection, args.table);
    } else {
      console.log('Invalid command. Use --show=tables or --show=structure --table=TABLE_NAME');
    }

    // Close the connection
    await connection.close();
    console.log('Connection closed');

  } catch (error) {
    console.error('Error connecting to the database:', error);
  }
}

main();
