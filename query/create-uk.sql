DECLARE
  v_sql VARCHAR2(4000);
BEGIN
  -- Drop any existing UK constraints first
  FOR r IN (
    SELECT constraint_name, table_name 
    FROM user_constraints 
    WHERE constraint_type = 'U' 
    AND constraint_name LIKE 'UK_%'
  ) LOOP
    v_sql := 'ALTER TABLE "' || r.table_name || '" DROP CONSTRAINT "' || r.constraint_name || '"';
    BEGIN
      EXECUTE IMMEDIATE v_sql;
    EXCEPTION WHEN OTHERS THEN
      NULL; -- Ignore any errors during drop
    END;
  END LOOP;

  -- Drop indexes if they exist
  FOR r IN (
    SELECT index_name 
    FROM user_indexes 
    WHERE index_name LIKE 'IDX_%'
  ) LOOP
    v_sql := 'DROP INDEX "' || r.index_name || '"';
    BEGIN
      EXECUTE IMMEDIATE v_sql;
    EXCEPTION WHEN OTHERS THEN
      NULL; -- Ignore any errors during drop
    END;
  END LOOP;

  -- Create unique constraints 
  BEGIN
    -- delete duplicate
    EXECUTE IMMEDIATE 'DELETE FROM BRANCHES WHERE ROWID NOT IN (SELECT MIN(ROWID) FROM BRANCHES GROUP BY KODE_SAP)';
    -- delete null
    EXECUTE IMMEDIATE 'DELETE FROM BRANCHES WHERE KODE_SAP IS NULL';
    v_sql := 'ALTER TABLE "BRANCHES" ADD CONSTRAINT "UK_BRANCHES_SAP" UNIQUE ("KODE_SAP")';
    EXECUTE IMMEDIATE v_sql;
  EXCEPTION WHEN OTHERS THEN
    IF SQLCODE != -2261 THEN -- Ignore if constraint already exists
      DBMS_OUTPUT.PUT_LINE('Error creating UK_BRANCHES_SAP: ' || SQLERRM);
    END IF;
  END;

  BEGIN
    -- delete duplicate
    EXECUTE IMMEDIATE 'DELETE FROM "REFERENCES" WHERE ROWID NOT IN (SELECT MIN(ROWID) FROM "REFERENCES" GROUP BY ENTITY)';
    -- delete null
    EXECUTE IMMEDIATE 'DELETE FROM "REFERENCES" WHERE ENTITY IS NULL';
    v_sql := 'ALTER TABLE "REFERENCES" ADD CONSTRAINT "UK_REFERENCES_ENTITY" UNIQUE ("ENTITY")';
    EXECUTE IMMEDIATE v_sql;
  EXCEPTION WHEN OTHERS THEN
    IF SQLCODE != -2261 THEN -- Ignore if constraint already exists
      DBMS_OUTPUT.PUT_LINE('Error creating UK_REFERENCES_ENTITY: ' || SQLERRM);
    END IF;
  END;
END;