-- Drop default Laravel tables if they exist
DECLARE
   TYPE table_list_t IS TABLE OF VARCHAR2(100);
   v_tables table_list_t := table_list_t('MIGRATIONS', 'FAILED_JOBS', 'PASSWORD_RESETS', 'USERS');
BEGIN
   FOR i IN 1..v_tables.COUNT LOOP
      BEGIN
         EXECUTE IMMEDIATE 'DROP TABLE "C##SIAPDEV4"."' || v_tables(i) || '" CASCADE CONSTRAINTS';
         DBMS_OUTPUT.PUT_LINE('Dropped table: ' || v_tables(i));
      EXCEPTION
         WHEN OTHERS THEN
            IF SQLCODE = -942 THEN
               DBMS_OUTPUT.PUT_LINE('Table does not exist: ' || v_tables(i));
            ELSE
               DBMS_OUTPUT.PUT_LINE('Error dropping table ' || v_tables(i) || ': ' || SQLERRM);
            END IF;
      END;
   END LOOP;
END;
/
