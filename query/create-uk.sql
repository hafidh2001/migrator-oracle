DECLARE
  v_sql VARCHAR2(4000);

  -- Define the table names and their primary key columns
  TYPE uk_def IS RECORD (
    table_name  VARCHAR2(100),
    uk_column   VARCHAR2(100)
  );
  TYPE uk_def_list IS TABLE OF uk_def;

  -- Define the tables and their unique key columns here
  l_tables uk_def_list := uk_def_list(
    uk_def('BRANCHES', 'KODE_SAP'),
    uk_def('REFERENCES', 'ENTITY')
  );

BEGIN
  FOR i IN 1..l_tables.COUNT LOOP
    BEGIN
      -- Delete duplicates
      v_sql := 'DELETE FROM ' || l_tables(i).table_name || 
               ' WHERE ROWID NOT IN (SELECT MIN(ROWID) FROM ' || 
               l_tables(i).table_name || ' GROUP BY ' || l_tables(i).uk_column || ')';
      EXECUTE IMMEDIATE v_sql;
      
      -- Delete nulls
      v_sql := 'DELETE FROM ' || l_tables(i).table_name || 
               ' WHERE ' || l_tables(i).uk_column || ' IS NULL';
      EXECUTE IMMEDIATE v_sql;
      
      -- Create primary key
      v_sql := 'ALTER TABLE "' || l_tables(i).table_name || 
               '" ADD CONSTRAINT "UK_' || l_tables(i).table_name || '" UNIQUE ("' || 
               l_tables(i).uk_column || '")';
      EXECUTE IMMEDIATE v_sql;
      
      DBMS_OUTPUT.PUT_LINE('Successfully created UK for ' || l_tables(i).table_name || '✅');
    EXCEPTION 
      WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error creating UK for ' || l_tables(i).table_name || 
                             ' ❌: ' || SQLERRM);
    END;
  END LOOP;
END;