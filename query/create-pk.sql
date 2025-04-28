DECLARE
  v_sql VARCHAR2(4000);

  -- Define the table names and their primary key columns
  TYPE pk_def IS RECORD (
    table_name  VARCHAR2(100),
    pk_column   VARCHAR2(100)
  );
  TYPE pk_def_list IS TABLE OF pk_def;
  
  -- Define the tables and their primary key columns here
  l_tables pk_def_list := pk_def_list(
    pk_def('ASSETACCOUNTS', 'COA'),
    pk_def('ASSETCLASSES', 'GROUPCLASSES_ID'),
    pk_def('ASSETS', 'NO_ASET'),
    pk_def('ASSET_SAP_FAILED', 'ID'),
    pk_def('BRANCHES', 'ID_CABANG'),
    pk_def('COSTCENTERS', 'KODE_PUSAT_BIAYA'),
    pk_def('DEPRECIATIONS', 'KODE_PENYUSUTAN'),
    pk_def('DEPRECIATION_VALUES', 'NO_ASET'),
    pk_def('DETAILASSETS', 'NO_ASET'),
    pk_def('DIMENSI_SATUAN', 'NAME'),
    pk_def('ELIMINATION', 'NO_ASET'),
    pk_def('GROUPASSETS', 'ID'),
    pk_def('GROUPCLASSES', 'ID'),
    pk_def('INSURANCES', 'NO_ASET'),
    pk_def('MASTER_ASURANSI', 'ID'),
    pk_def('MONITORING_FAILED', 'ID'),
    pk_def('MONITORING_INTEGRATOR', 'ID'),
    pk_def('NOTIFIKASI', 'ID_NOTIFIKASI'),
    pk_def('PBB', 'NO_ASET'),
    pk_def('PERIOD', 'ID'),
    pk_def('PERIOD_REQUEST', 'ID'),
    pk_def('PICTUREASSETS', 'NO_ASET'),
    pk_def('REFERENCES', 'ID'),
    pk_def('ROLES', 'ID'),
    pk_def('USERS', 'ID'),
    pk_def('USES', 'NO_ASET')
  );

BEGIN
  FOR i IN 1..l_tables.COUNT LOOP
    BEGIN
      -- Delete duplicates
      v_sql := 'DELETE FROM ' || l_tables(i).table_name || 
               ' WHERE ROWID NOT IN (SELECT MIN(ROWID) FROM ' || 
               l_tables(i).table_name || ' GROUP BY ' || l_tables(i).pk_column || ')';
      EXECUTE IMMEDIATE v_sql;
      
      -- Delete nulls
      v_sql := 'DELETE FROM ' || l_tables(i).table_name || 
               ' WHERE ' || l_tables(i).pk_column || ' IS NULL';
      EXECUTE IMMEDIATE v_sql;
      
      -- Create primary key
      v_sql := 'ALTER TABLE "' || l_tables(i).table_name || 
               '" ADD CONSTRAINT "' || l_tables(i).table_name || '_PK" PRIMARY KEY ("' || 
               l_tables(i).pk_column || '")';
      EXECUTE IMMEDIATE v_sql;
      
      DBMS_OUTPUT.PUT_LINE('Successfully created PK for ' || l_tables(i).table_name || '✅');
    EXCEPTION 
      WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error creating PK for ' || l_tables(i).table_name || 
                             ' ❌: ' || SQLERRM);
    END;
  END LOOP;
END;