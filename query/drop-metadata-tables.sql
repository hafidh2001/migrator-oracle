-- Drop all MD_ prefix tables and migration-related tables
DECLARE
   CURSOR tables_to_drop IS
      SELECT table_name 
      FROM user_tables 
      WHERE table_name LIKE 'MD_%' 
         OR table_name LIKE 'MIGR_%' 
         OR table_name = 'MIGRLOG'
      ORDER BY table_name DESC;
   v_table_name VARCHAR2(200);
BEGIN
   FOR v_table IN tables_to_drop LOOP
      BEGIN
         EXECUTE IMMEDIATE 'DROP TABLE "' || v_table.table_name || '" CASCADE CONSTRAINTS';
         DBMS_OUTPUT.PUT_LINE('Dropped table: ' || v_table.table_name);
      EXCEPTION
         WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error dropping table ' || v_table.table_name || ': ' || SQLERRM);
      END;
   END LOOP;
END;
/
