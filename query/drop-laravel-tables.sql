-- Drop default Laravel tables and sequences if they exist
DECLARE
   TYPE table_list_t IS TABLE OF VARCHAR2(100);
   v_tables table_list_t := table_list_t('MIGRATIONS', 'FAILED_JOBS', 'PASSWORD_RESETS', 'USERS', 'JOBS');
   
   PROCEDURE drop_sequence_if_exists(p_sequence_name IN VARCHAR2) IS
   BEGIN
      EXECUTE IMMEDIATE 'DROP SEQUENCE "C##SIAPDEV4"."' || p_sequence_name || '"';
   EXCEPTION
      WHEN OTHERS THEN
         IF SQLCODE != -2289 THEN
            DBMS_OUTPUT.PUT_LINE('Error dropping sequence ' || p_sequence_name || ': ' || SQLERRM);
         END IF;
   END;
BEGIN
   -- Drop sequences first
   drop_sequence_if_exists('JOBS_SEQ');
   drop_sequence_if_exists('MIGRATIONS_ID_SEQ');
   drop_sequence_if_exists('FAILED_JOBS_ID_SEQ');
   drop_sequence_if_exists('USERS_ID_SEQ');
   
   -- Then drop tables
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
