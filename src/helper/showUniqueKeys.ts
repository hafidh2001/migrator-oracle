import type { Connection } from "oracledb";
import { dbConfig } from "../config/database";

export async function showTableUniqueKey(
  connection: Connection,
  tableName?: string
): Promise<void> {
  if (tableName) {
    // Show unique key for a specific table
    const result = await connection.execute(
      `SELECT cols.column_name
       FROM all_constraints cons
       JOIN all_cons_columns cols ON cons.constraint_name = cols.constraint_name
       AND cons.owner = cols.owner
       JOIN all_tables t ON t.table_name = cons.table_name
       AND t.owner = cons.owner
       WHERE cons.owner = :1
       AND cons.table_name = :2
       AND cons.constraint_type = 'U'
       AND cons.table_name NOT LIKE 'BIN$%'
       ORDER BY cols.position`,
      [(dbConfig.user || "").toUpperCase(), tableName.toUpperCase()]
    );

    console.log(`\nUnique Key for table ${tableName}:`);
    console.log("-".repeat(50));
    console.log("COLUMN NAME".padEnd(30));
    console.log("-".repeat(50));

    if (result.rows && result.rows.length > 0) {
      result.rows.forEach((row: any) => {
        console.log(`${row[0]}`.padEnd(30));
      });
    } else {
      console.log("No unique key found".padEnd(50));
    }
    console.log("-".repeat(50));
  } else {
    // Show unique keys for all tables
    const result = await connection.execute(
      `SELECT cons.table_name, cols.column_name, cons.constraint_name
       FROM all_constraints cons
       JOIN all_cons_columns cols ON cons.constraint_name = cols.constraint_name
       AND cons.owner = cols.owner
       JOIN all_tables t ON t.table_name = cons.table_name 
       AND t.owner = cons.owner
       WHERE cons.owner = :1
       AND cons.constraint_type = 'U'
       AND cons.table_name NOT LIKE 'BIN$%'
       ORDER BY cons.table_name, cols.position`,
      [(dbConfig.user || "").toUpperCase()]
    );

    console.log("\nUnique Keys for all tables:");
    console.log("-".repeat(80));
    console.log("TABLE NAME".padEnd(25) + "UNIQUE KEY".padEnd(25) + "CONSTRAINT NAME".padEnd(25));
    console.log("-".repeat(80));

    const rows = result.rows || [];
    if (rows.length > 0) {
      let currentTable = "";
      let uniqueKeyColumns: string[] = [];
      let constraintColumns: string[] = [];

      rows.forEach((row: any, index: number) => {
        const [tableName, columnName, constraint_name] = row;

        if (currentTable !== tableName) {
          if (currentTable !== "") {
            console.log(
              currentTable.padEnd(25) + uniqueKeyColumns.join(", ").padEnd(25) + constraintColumns.join(", ").padEnd(40)
            );
          }
          currentTable = tableName;
          uniqueKeyColumns = [columnName];
          constraintColumns = [constraint_name];
        } else {
          uniqueKeyColumns.push(columnName);
          constraintColumns.push(constraint_name);
        }

        // Print the last table
        if (index === rows.length - 1) {
          console.log(
            currentTable.padEnd(25) + uniqueKeyColumns.join(", ").padEnd(25) + constraintColumns.join(", ").padEnd(40)
          );
        }
      });
    } else {
      console.log("No unique keys found".padEnd(80));
    }
    console.log("-".repeat(80));
  }
}
