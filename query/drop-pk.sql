DECLARE
  v_sql VARCHAR2(4000);
BEGIN
  -- Drop existing primary key constraints
  FOR r IN (
    SELECT constraint_name, table_name 
    FROM user_constraints 
    WHERE constraint_type = 'P'
    AND constraint_name LIKE '%_PK'
  ) LOOP
    v_sql := 'ALTER TABLE "' || r.table_name || '" DROP CONSTRAINT "' || r.constraint_name || '"';
    BEGIN
      EXECUTE IMMEDIATE v_sql;
    EXCEPTION WHEN OTHERS THEN
      NULL; -- Ignore errors during drop
    END;
  END LOOP;
END;