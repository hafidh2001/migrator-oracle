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

  -- Define the tables and their foreign key columns here
  l_tables fk_def_list := fk_def_list(
    fk_def('ASSETS', 'ASSETCLASSES_ID', 'ASSETCLASSES', 'ID'),
    fk_def('ASSETS', 'GROUPASSET_ID', 'GROUPASSETS', 'ID'),
    fk_def('ASSETS', 'GROUPCLASSES_ID', 'GROUPCLASSES', 'ID'),
    fk_def('ASSETS', 'BRANCHE_ID', 'BRANCHES', 'ID_CABANG'),
    fk_def('ASSETCLASSES', 'GROUPASSET_ID', 'GROUPASSETS', 'ID'),
    fk_def('ASSETCLASSES', 'GROUPCLASSES_ID', 'GROUPCLASSES', 'ID'),
    fk_def('DETAILASSETS', 'KONDISI_FISIK', 'REFERENCES', 'ENTITY'),
    fk_def('DETAILASSETS', 'STATUS_PEROLEHAN', 'REFERENCES', 'ENTITY'),
    fk_def('DETAILASSETS', 'BUKTI_KEPEMILIKAN', 'REFERENCES', 'ENTITY'),
    fk_def('DETAILASSETS', 'STATUS_PENGELOLAAN', 'REFERENCES', 'ENTITY'),
    fk_def('DETAILASSETS', 'STATUS_ASURANSI', 'REFERENCES', 'ENTITY'),
    fk_def('DETAILASSETS', 'ASSET_ID', 'ASSETS', 'ID'),
    fk_def('DETAILASSETS', 'INSURANCE_ID', 'INSURANCES', 'ID'),
    fk_def('DETAILASSETS', 'DEPRECIATION_VALUE_ID', 'DEPRECIATION_VALUES', 'ID'),
    fk_def('DETAILASSETS', 'ELIMINATION_ID', 'ELIMINATION', 'ID'),
    fk_def('DETAILASSETS', 'PBB_ID', 'PBB', 'ID'),
    fk_def('NOTIFIKASI', 'DETAILASSET_ID', 'DETAILASSETS', 'ID'),
    fk_def('PICTUREASSETS', 'DETAILASSET_ID', 'DETAILASSETS', 'ID'),
    fk_def('USERS', 'ID_ROLE', 'ROLES', 'ID'),
    -- fk_def('USERS', 'ID_CABANG', 'BRANCHES', 'KODE_SAP'), RELASI USER DENGAN BRANCHES TIDAK PERLU KARENA, FLOWNYA ADALAH 
    -- USERS.ID_CABANG AKAN DIISI DARI BRANCHES.KODE_SAP YANG SESUAI DENGAN SSO.PROFIT_CENTER 
    fk_def('PERIOD_REQUEST', 'ID_USER', 'USERS', 'ID'),
    fk_def('USES', 'DETAILASSET_ID', 'DETAILASSETS', 'ID'),
    fk_def('USES', 'USES_TYPE', 'REFERENCES', 'ENTITY')
  );

BEGIN
  FOR i IN 1..l_tables.COUNT LOOP
    BEGIN
      -- Set invalid foreign key values to NULL instead of deleting data
      v_sql := 'UPDATE ' || l_tables(i).table_name ||
               ' SET ' || l_tables(i).column_name || ' = NULL' ||
               ' WHERE ' || l_tables(i).column_name || ' IS NOT NULL' ||
               ' AND ' || l_tables(i).column_name ||
               ' NOT IN (SELECT ' || l_tables(i).ref_column_name ||
               ' FROM ' || l_tables(i).ref_table_name ||
               ' WHERE ' || l_tables(i).ref_column_name || ' IS NOT NULL)';
      EXECUTE IMMEDIATE v_sql;

      -- Create foreign key with nullable constraint
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