import { parseArgs, showHelp } from './src/helper/args';
import { initializeConnection, closeConnection } from './src/helper/db';
import { showTables } from './src/helper/showTables';
import { showTableStructure } from './src/helper/showStructure';
import { showForeignKeys } from './src/helper/showForeignKeys';
import { showSequences } from './src/helper/showSequences';
import { showTablePrimaryKey } from './src/helper/showPrimaryKeys';
import { runQuery } from './src/helper/runQuery';

async function main() {
  const args = parseArgs();
  try {
    const connection = await initializeConnection();
    
    if (args.help) {
      showHelp();
      await closeConnection(connection);
      return;
    }

    if (args.query) {
      await runQuery(connection, args.query);
      await closeConnection(connection);
      return;
    }

    if (!args.show) {
      console.log('\nUse --help to see available commands');
      await closeConnection(connection);
      return;
    }

    switch (args.show) {
      case 'tables':
        await showTables(connection);
        break;
      case 'structure':
        if (args.table) {
          await showTableStructure(connection, args.table);
        } else {
          console.log('\nMissing table name. Use: --show=structure --table=TABLE_NAME');
        }
        break;
      case 'fk':
        await showForeignKeys(connection, args.table);
        break;
      case 'sequences':
        await showSequences(connection);
        break;
      case 'pk':
        await showTablePrimaryKey(connection, args.table);
        break;
      default:
        console.log('\nInvalid command. Use --help to see available commands');
    }

    await closeConnection(connection);

  } catch (error) {
    console.error('Error connecting to the database:', error);
  }
}

main();
