import type { Connection } from "oracledb";
import { dbConfig } from "../config/database";
import { existsSync } from "fs";
import { resolve } from "path";
import * as csvWriter from "csv-writer"; // CSV writer
import Progress from "progress"; // Correct import for progress bar

// Example: exportTablesToCSV with default outputDir value
export async function exportTablesToCSV(
  connection: Connection,
  outputDir: string = "export-csv"
): Promise<void> {
  // Ensure the output directory exists
  if (!existsSync(outputDir)) {
    console.log(`Creating directory: ${outputDir}`);
    // You can use fs.mkdirSync here if you want to create it automatically
    // fs.mkdirSync(outputDir, { recursive: true });
  }

  try {
    // Retrieve the list of tables
    const result = await connection.execute(
      `SELECT table_name FROM all_tables WHERE owner = :1`,
      [(dbConfig.user || "").toUpperCase()]
    );

    const tables = (result.rows || []).map((row) => (row as unknown[])[0]);

    // Loop through tables and export each one to CSV
    for (const table of tables) {
      console.log(`Exporting table: ${table}`);

      // Progress bar initialization
      const bar = new Progress(":bar :current/:total :percent", {
        total: 100, // We'll update this dynamically below
        width: 30, // Adjust the width as needed
        complete: "=",
        incomplete: " ",
      });

      // Replace this with actual data retrieval logic to get data from Oracle table
      const query = `SELECT * FROM ${table}`;
      const tableData = await connection.execute(query);

      // Check if tableData and tableData.rows are defined
      if (!tableData || !tableData.rows) {
        console.log(`No data found for table: ${table}`);
        continue; // Skip this table if no rows found
      }

      // Initialize the CSV writer
      const csvFilePath = resolve(outputDir, `${table}.csv`);
      const writer = csvWriter.createObjectCsvWriter({
        path: csvFilePath,
        header: Object.keys(tableData.metaData || {}).map((column) => ({
          id: column,
          title: column,
        })),
      });

      // Write the data to CSV file
      const totalRecords = tableData.rows.length;
      let progressCounter = 0;

      // Loop through each record and update progress
      for (const row of tableData.rows) {
        // Cast row to a proper type (ObjectMap or Record<string, any>)
        const rowData = row as Record<string, any>;

        // Write the row to CSV
        await writer.writeRecords([rowData]); // Writing one record at a time
        progressCounter++;
        bar.update(progressCounter / totalRecords); // Update the progress bar
      }

      console.log(`Table ${table} exported successfully to ${csvFilePath}`);
    }
  } catch (error) {
    console.error("Error exporting tables to CSV:", error);
  }
}
