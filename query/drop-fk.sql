DECLARE
  v_sql VARCHAR2(4000);
BEGIN
  -- Drop existing foreign key constraints
  FOR r IN (
    SELECT constraint_name, table_name 
    FROM user_constraints 
    WHERE constraint_type = 'R' 
    AND constraint_name LIKE 'FK_%'
  ) LOOP
    v_sql := 'ALTER TABLE "' || r.table_name || '" DROP CONSTRAINT "' || r.constraint_name || '"';
    BEGIN
      EXECUTE IMMEDIATE v_sql;
    EXCEPTION WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error dropping ' || r.constraint_name || ' ❌: ' || SQLERRM);
    END;
  END LOOP;
END;