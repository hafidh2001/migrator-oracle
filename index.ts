import { parseArgs, showHelp } from "./src/helper/args";
import { initializeConnection, closeConnection } from "./src/helper/db";
import { showTables } from "./src/helper/showTables";
import { showTableStructure } from "./src/helper/showStructure";
import { showForeignKeys } from "./src/helper/showForeignKeys";
import { showSequences } from "./src/helper/showSequences";
import { showTablePrimaryKey } from "./src/helper/showPrimaryKeys";
import { showSchemaDiagram } from "./src/helper/showSchemaDiagram";
import { runQuery } from "./src/helper/runQuery";
import { compareFilesWithTables } from "./src/helper/compareFilesWithTables";
import { exportTablesToCSV } from "./src/helper/exportTablesToCSV";
import { showTableUniqueKey } from "./src/helper/showUniqueKeys";

async function main() {
  const args = parseArgs();
  let connection;

  try {
    connection = await initializeConnection();

    if (args.help) {
      showHelp();
      return;
    }

    if (args.query) {
      await runQuery(connection, args.query);
      return;
    }

    if (args.compare === "csv") {
      if (!args.path) {
        console.error(
          "\nMissing directory path. Use: --compare=csv --path=BACKUP_DIRECTORY"
        );
        process.exit(1);
      }
      await compareFilesWithTables(connection, args.path);
      return;
    }

    if (args.export === "csv") {
      const exportPath = args.path || "export-csv";
      console.log(`Exporting tables to CSV in directory: ${exportPath}`);
      await exportTablesToCSV(connection, exportPath);
      return;
    }

    if (!args.show) {
      console.error("\nUse --help to see available commands");
      process.exit(1);
    }

    switch (args.show) {
      case "sequences":
        await showSequences(connection);
        break;
      case "tables":
        await showTables(connection);
        break;
      case "structure":
        if (!args.table) {
          console.error(
            "\nMissing table name. Use: --show=structure --table=TABLE_NAME"
          );
          process.exit(1);
        }
        await showTableStructure(connection, args.table);
        break;
      case "pk":
      case "uk":
      case "fk":
        if (args.show === "pk")
          await showTablePrimaryKey(connection, args.table);
        if (args.show === "uk")
          await showTableUniqueKey(connection, args.table);
        if (args.show === "fk") await showForeignKeys(connection, args.table);
        break;
      case "schema":
        await showSchemaDiagram(connection, args.output);
        break;
      default:
        console.error(
          "\nInvalid command. Use --help to see available commands"
        );
        process.exit(1);
    }
  } catch (error) {
    console.error("Error:", error instanceof Error ? error.message : error);
    process.exit(1);
  } finally {
    if (connection) await closeConnection(connection);
  }
}

main().catch(console.error);
