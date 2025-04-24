import { parseArgs, showHelp } from './src/helper/args';
import { initializeConnection, closeConnection } from './src/helper/db';
import { showTables } from './src/helper/showTables';
import { showTableStructure } from './src/helper/showStructure';
import { showTableRelations } from './src/helper/showRelations';

async function main() {
  const args = parseArgs();
  try {
    const connection = await initializeConnection();
    
    if (args.help) {
      showHelp();
      await closeConnection(connection);
      return;
    }

    if (!args.show) {
      console.log('\nUse --help to see available commands');
      await closeConnection(connection);
      return;
    }

    if (args.show === 'tables') {
      await showTables(connection);
    } else if (args.show === 'structure' && args.table) {
      await showTableStructure(connection, args.table);
    } else if (args.show === 'relations') {
      await showTableRelations(connection, args.table);
    } else {
      console.log('\nInvalid command. Use --help to see available commands');
    }

    await closeConnection(connection);

  } catch (error) {
    console.error('Error connecting to the database:', error);
  }
}

main();
