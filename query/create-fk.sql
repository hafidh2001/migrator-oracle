DECLARE
  v_sql VARCHAR2(4000);

  -- Define the table names and their primary key columns
  TYPE fk_def IS RECORD (
    table_name       VARCHAR2(100),
    column_name      VARCHAR2(100),
    ref_table_name   VARCHAR2(100),
    ref_column_name  VARCHAR2(100)
  );
  TYPE fk_def_list IS TABLE OF fk_def;

  -- Define the tables and their unique key columns here
  l_tables fk_def_list := fk_def_list(
    fk_def('ASSETS', 'GROUPCLASSES_ID', 'ASSETCLASSES', 'GROUPCLASSES_ID'),
    fk_def('ASSETS', 'KELAS_ASET', 'GROUPCLASSES', 'ID'),
    fk_def('ASSETS', 'KODE_CABANG', 'BRANCHES', 'KODE_SAP'),
    fk_def('DEPRECIATION_VALUES', 'NO_ASET', 'ASSETS', 'NO_ASET'),
    fk_def('DETAILASSETS', 'KONDISI_FISIK', 'REFERENCES', 'ENTITY'),
    fk_def('DETAILASSETS', 'STATUS_PEROLEHAN', 'REFERENCES', 'ENTITY'),
    fk_def('DETAILASSETS', 'NO_ASET', 'ASSETS', 'NO_ASET'),
    fk_def('PICTUREASSETS', 'NO_ASET', 'DETAILASSETS', 'NO_ASET'),
    fk_def('USERS', 'ID_ROLE', 'ROLES', 'ID'),
    fk_def('USES', 'NO_ASET', 'ASSETS', 'NO_ASET')
  );

BEGIN
  FOR i IN 1..l_tables.COUNT LOOP
    BEGIN
      -- Delete non-matching data
      v_sql := 'DELETE FROM ' || l_tables(i).table_name || 
               ' WHERE ' || l_tables(i).column_name || 
               ' NOT IN (SELECT ' || l_tables(i).ref_column_name || 
               ' FROM ' || l_tables(i).ref_table_name || ')';
      EXECUTE IMMEDIATE v_sql;

      -- Create foreign key
      v_sql := 'ALTER TABLE "' || l_tables(i).table_name || 
               '" ADD CONSTRAINT "FK_' || l_tables(i).table_name || '_' || l_tables(i).column_name || '__' || l_tables(i).ref_table_name || '_' || l_tables(i).ref_column_name ||
               '" FOREIGN KEY ("' || l_tables(i).column_name || 
               '") REFERENCES "' || l_tables(i).ref_table_name || 
               '"("' || l_tables(i).ref_column_name || '")';
      EXECUTE IMMEDIATE v_sql;
      
      DBMS_OUTPUT.PUT_LINE('Successfully created FK for FK_' || l_tables(i).table_name || '_' || l_tables(i).column_name || '__' || l_tables(i).ref_table_name || '_' || l_tables(i).ref_column_name || '✅');
    EXCEPTION 
      WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error creating FK for FK_' || l_tables(i).table_name || '_' || l_tables(i).column_name || '__' || l_tables(i).ref_table_name || '_' || l_tables(i).ref_column_name || 
                             ' ❌: ' || SQLERRM);
    END;
  END LOOP;
END;