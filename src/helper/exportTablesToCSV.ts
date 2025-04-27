import type { Connection } from "oracledb";
import { dbConfig } from "../config/database";
import { existsSync, mkdirSync } from "fs";
import { resolve } from "path";
import * as csvWriter from "csv-writer";
import Progress from "progress";

export async function exportTablesToCSV(
  connection: Connection,
  outputDir: string = "export-csv"
): Promise<void> {
  // Ensure the output directory exists
  if (!existsSync(outputDir)) {
    console.log(`Creating directory: ${outputDir}`);
    mkdirSync(outputDir, { recursive: true });
  }

  try {
    // Retrieve the list of tables
    const result = await connection.execute(
      `SELECT table_name FROM all_tables WHERE owner = :1`,
      [(dbConfig.user || "").toUpperCase()]
    );

    const tables = (result.rows || []).map((row) => (row as unknown[])[0] as string);

    for (const table of tables) {
      console.log(`Exporting table: ${table}`);

      const query = `SELECT * FROM ${table}`;
      const tableData = await connection.execute(query);

      const metaData = tableData.metaData;
      if (!metaData) {
        console.log(`No metadata found for table: ${table}`);
        continue;
      }
      const columns = metaData.map((col) => col.name);

      const csvFilePath = resolve(outputDir, `${table}.csv`);
      const writer = csvWriter.createObjectCsvWriter({
        path: csvFilePath,
        header: columns.map((col) => ({
          id: col,
          title: col,
        })),
        append: false,
      });

      const rows = tableData.rows || [];
      const totalRecords = rows.length;
      let progressCounter = 0;

      // Progress bar
      const bar = new Progress(":bar :current/:total :percent", {
        total: totalRecords || 1,
        width: 30,
        complete: "=",
        incomplete: " ",
      });

      if (rows.length > 0) {
        const records = rows.map((row) => {
          const rowArray = row as (string | number | null | undefined)[];
          const obj: Record<string, any> = {};
          rowArray.forEach((value, index) => {
            obj[columns[index]] = value ?? "";
          });
          return obj;
        });

        await writer.writeRecords(records);

        for (const _ of records) {
          progressCounter++;
          bar.update(progressCounter / totalRecords);
        }
      } else {
        // Even no rows: create CSV with headers only
        await writer.writeRecords([]);
        bar.update(1);
      }

      console.log(`Table ${table} exported successfully to ${csvFilePath}`);
    }
  } catch (error) {
    console.error("Error exporting tables to CSV:", error);
  }
}
