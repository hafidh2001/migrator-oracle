-- Script untuk membuat sequences berdasarkan nilai maksimum ID dari setiap tabel
-- Generate sequences for all tables with ID NUMBER columns

DECLARE
  v_max_id       NUMBER;
  v_seq_curr     NUMBER;
  v_increment    NUMBER;
  v_sql          VARCHAR2(4000);
  v_exists       NUMBER;
BEGIN
  DBMS_OUTPUT.PUT_LINE('Creating sequences for all tables with ID columns...');
  DBMS_OUTPUT.PUT_LINE('========================================================');
  
  -- 1. ASSETS table
  BEGIN
    -- Check if sequence exists
    SELECT COUNT(*) INTO v_exists 
    FROM user_sequences WHERE sequence_name = 'SEQ_ASSETS_ID';
    
    IF v_exists = 0 THEN
      SELECT NVL(MAX(ID), 0) INTO v_max_id FROM ASSETS;
      v_sql := 'CREATE SEQUENCE SEQ_ASSETS_ID START WITH ' || (v_max_id + 1) || ' INCREMENT BY 1 NOCACHE NOCYCLE';
      EXECUTE IMMEDIATE v_sql;
      DBMS_OUTPUT.PUT_LINE('✓ SEQ_ASSETS_ID created starting from ' || (v_max_id + 1));
    ELSE
      DBMS_OUTPUT.PUT_LINE('⚠ SEQ_ASSETS_ID already exists');
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('✗ Error creating SEQ_ASSETS_ID: ' || SQLERRM);
  END;

  -- 2. ASSET_SAP_FAILED table
  BEGIN
    SELECT COUNT(*) INTO v_exists 
    FROM user_sequences WHERE sequence_name = 'SEQ_ASSET_SAP_FAILED_ID';
    
    IF v_exists = 0 THEN
      SELECT NVL(MAX(ID), 0) INTO v_max_id FROM ASSET_SAP_FAILED;
      v_sql := 'CREATE SEQUENCE SEQ_ASSET_SAP_FAILED_ID START WITH ' || (v_max_id + 1) || ' INCREMENT BY 1 NOCACHE NOCYCLE';
      EXECUTE IMMEDIATE v_sql;
      DBMS_OUTPUT.PUT_LINE('✓ SEQ_ASSET_SAP_FAILED_ID created starting from ' || (v_max_id + 1));
    ELSE
      DBMS_OUTPUT.PUT_LINE('⚠ SEQ_ASSET_SAP_FAILED_ID already exists');
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('✗ Error creating SEQ_ASSET_SAP_FAILED_ID: ' || SQLERRM);
  END;

  -- 3. DEPRECIATION_VALUES table
  BEGIN
    SELECT COUNT(*) INTO v_exists 
    FROM user_sequences WHERE sequence_name = 'SEQ_DEP_VALUES_ID';
    
    IF v_exists = 0 THEN
      SELECT NVL(MAX(ID), 0) INTO v_max_id FROM DEPRECIATION_VALUES;
      v_sql := 'CREATE SEQUENCE SEQ_DEP_VALUES_ID START WITH ' || (v_max_id + 1) || ' INCREMENT BY 1 NOCACHE NOCYCLE';
      EXECUTE IMMEDIATE v_sql;
      DBMS_OUTPUT.PUT_LINE('✓ SEQ_DEP_VALUES_ID created starting from ' || (v_max_id + 1));
    ELSE
      DBMS_OUTPUT.PUT_LINE('⚠ SEQ_DEP_VALUES_ID already exists');
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('✗ Error creating SEQ_DEP_VALUES_ID: ' || SQLERRM);
  END;

  -- 4. DETAILASSETS table
  BEGIN
    SELECT COUNT(*) INTO v_exists 
    FROM user_sequences WHERE sequence_name = 'SEQ_DETAILASSETS_ID';
    
    IF v_exists = 0 THEN
      SELECT NVL(MAX(ID), 0) INTO v_max_id FROM DETAILASSETS;
      v_sql := 'CREATE SEQUENCE SEQ_DETAILASSETS_ID START WITH ' || (v_max_id + 1) || ' INCREMENT BY 1 NOCACHE NOCYCLE';
      EXECUTE IMMEDIATE v_sql;
      DBMS_OUTPUT.PUT_LINE('✓ SEQ_DETAILASSETS_ID created starting from ' || (v_max_id + 1));
    ELSE
      DBMS_OUTPUT.PUT_LINE('⚠ SEQ_DETAILASSETS_ID already exists');
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('✗ Error creating SEQ_DETAILASSETS_ID: ' || SQLERRM);
  END;

  -- 5. ELIMINATION table
  BEGIN
    SELECT COUNT(*) INTO v_exists 
    FROM user_sequences WHERE sequence_name = 'SEQ_ELIMINATION_ID';
    
    IF v_exists = 0 THEN
      SELECT NVL(MAX(ID), 0) INTO v_max_id FROM ELIMINATION;
      v_sql := 'CREATE SEQUENCE SEQ_ELIMINATION_ID START WITH ' || (v_max_id + 1) || ' INCREMENT BY 1 NOCACHE NOCYCLE';
      EXECUTE IMMEDIATE v_sql;
      DBMS_OUTPUT.PUT_LINE('✓ SEQ_ELIMINATION_ID created starting from ' || (v_max_id + 1));
    ELSE
      DBMS_OUTPUT.PUT_LINE('⚠ SEQ_ELIMINATION_ID already exists');
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('✗ Error creating SEQ_ELIMINATION_ID: ' || SQLERRM);
  END;

  -- 6. GROUPASSETS table
  BEGIN
    SELECT COUNT(*) INTO v_exists 
    FROM user_sequences WHERE sequence_name = 'SEQ_GROUPASSETS_ID';
    
    IF v_exists = 0 THEN
      SELECT NVL(MAX(ID), 0) INTO v_max_id FROM GROUPASSETS;
      v_sql := 'CREATE SEQUENCE SEQ_GROUPASSETS_ID START WITH ' || (v_max_id + 1) || ' INCREMENT BY 1 NOCACHE NOCYCLE';
      EXECUTE IMMEDIATE v_sql;
      DBMS_OUTPUT.PUT_LINE('✓ SEQ_GROUPASSETS_ID created starting from ' || (v_max_id + 1));
    ELSE
      DBMS_OUTPUT.PUT_LINE('⚠ SEQ_GROUPASSETS_ID already exists');
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('✗ Error creating SEQ_GROUPASSETS_ID: ' || SQLERRM);
  END;

  -- 7. GROUPCLASSES table
  BEGIN
    SELECT COUNT(*) INTO v_exists 
    FROM user_sequences WHERE sequence_name = 'SEQ_GROUPCLASSES_ID';
    
    IF v_exists = 0 THEN
      SELECT NVL(MAX(ID), 0) INTO v_max_id FROM GROUPCLASSES;
      v_sql := 'CREATE SEQUENCE SEQ_GROUPCLASSES_ID START WITH ' || (v_max_id + 1) || ' INCREMENT BY 1 NOCACHE NOCYCLE';
      EXECUTE IMMEDIATE v_sql;
      DBMS_OUTPUT.PUT_LINE('✓ SEQ_GROUPCLASSES_ID created starting from ' || (v_max_id + 1));
    ELSE
      DBMS_OUTPUT.PUT_LINE('⚠ SEQ_GROUPCLASSES_ID already exists');
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('✗ Error creating SEQ_GROUPCLASSES_ID: ' || SQLERRM);
  END;

  -- 8. INSURANCES table
  BEGIN
    SELECT COUNT(*) INTO v_exists 
    FROM user_sequences WHERE sequence_name = 'SEQ_INSURANCES_ID';
    
    IF v_exists = 0 THEN
      SELECT NVL(MAX(ID), 0) INTO v_max_id FROM INSURANCES;
      v_sql := 'CREATE SEQUENCE SEQ_INSURANCES_ID START WITH ' || (v_max_id + 1) || ' INCREMENT BY 1 NOCACHE NOCYCLE';
      EXECUTE IMMEDIATE v_sql;
      DBMS_OUTPUT.PUT_LINE('✓ SEQ_INSURANCES_ID created starting from ' || (v_max_id + 1));
    ELSE
      DBMS_OUTPUT.PUT_LINE('⚠ SEQ_INSURANCES_ID already exists');
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('✗ Error creating SEQ_INSURANCES_ID: ' || SQLERRM);
  END;

  -- 9. MASTER_ASURANSI table
  BEGIN
    SELECT COUNT(*) INTO v_exists 
    FROM user_sequences WHERE sequence_name = 'SEQ_MASTER_ASURANSI_ID';
    
    IF v_exists = 0 THEN
      SELECT NVL(MAX(ID), 0) INTO v_max_id FROM MASTER_ASURANSI;
      v_sql := 'CREATE SEQUENCE SEQ_MASTER_ASURANSI_ID START WITH ' || (v_max_id + 1) || ' INCREMENT BY 1 NOCACHE NOCYCLE';
      EXECUTE IMMEDIATE v_sql;
      DBMS_OUTPUT.PUT_LINE('✓ SEQ_MASTER_ASURANSI_ID created starting from ' || (v_max_id + 1));
    ELSE
      DBMS_OUTPUT.PUT_LINE('⚠ SEQ_MASTER_ASURANSI_ID already exists');
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('✗ Error creating SEQ_MASTER_ASURANSI_ID: ' || SQLERRM);
  END;

  -- 10. MONITORING_FAILED table
  BEGIN
    SELECT COUNT(*) INTO v_exists 
    FROM user_sequences WHERE sequence_name = 'SEQ_MONITORING_FAILED_ID';
    
    IF v_exists = 0 THEN
      SELECT NVL(MAX(ID), 0) INTO v_max_id FROM MONITORING_FAILED;
      v_sql := 'CREATE SEQUENCE SEQ_MONITORING_FAILED_ID START WITH ' || (v_max_id + 1) || ' INCREMENT BY 1 NOCACHE NOCYCLE';
      EXECUTE IMMEDIATE v_sql;
      DBMS_OUTPUT.PUT_LINE('✓ SEQ_MONITORING_FAILED_ID created starting from ' || (v_max_id + 1));
    ELSE
      DBMS_OUTPUT.PUT_LINE('⚠ SEQ_MONITORING_FAILED_ID already exists');
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('✗ Error creating SEQ_MONITORING_FAILED_ID: ' || SQLERRM);
  END;

  -- 11. MONITORING_INTEGRATOR table
  BEGIN
    SELECT COUNT(*) INTO v_exists 
    FROM user_sequences WHERE sequence_name = 'SEQ_MONITORING_INTEGRATOR_ID';
    
    IF v_exists = 0 THEN
      SELECT NVL(MAX(ID), 0) INTO v_max_id FROM MONITORING_INTEGRATOR;
      v_sql := 'CREATE SEQUENCE SEQ_MONITORING_INTEGRATOR_ID START WITH ' || (v_max_id + 1) || ' INCREMENT BY 1 NOCACHE NOCYCLE';
      EXECUTE IMMEDIATE v_sql;
      DBMS_OUTPUT.PUT_LINE('✓ SEQ_MONITORING_INTEGRATOR_ID created starting from ' || (v_max_id + 1));
    ELSE
      DBMS_OUTPUT.PUT_LINE('⚠ SEQ_MONITORING_INTEGRATOR_ID already exists');
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('✗ Error creating SEQ_MONITORING_INTEGRATOR_ID: ' || SQLERRM);
  END;

  -- 12. NOTIFIKASI table (uses ID_NOTIFIKASI column)
  BEGIN
    SELECT COUNT(*) INTO v_exists 
    FROM user_sequences WHERE sequence_name = 'SEQ_NOTIFIKASI_ID';
    
    IF v_exists = 0 THEN
      SELECT NVL(MAX(ID_NOTIFIKASI), 0) INTO v_max_id FROM NOTIFIKASI;
      v_sql := 'CREATE SEQUENCE SEQ_NOTIFIKASI_ID START WITH ' || (v_max_id + 1) || ' INCREMENT BY 1 NOCACHE NOCYCLE';
      EXECUTE IMMEDIATE v_sql;
      DBMS_OUTPUT.PUT_LINE('✓ SEQ_NOTIFIKASI_ID created starting from ' || (v_max_id + 1));
    ELSE
      DBMS_OUTPUT.PUT_LINE('⚠ SEQ_NOTIFIKASI_ID already exists');
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('✗ Error creating SEQ_NOTIFIKASI_ID: ' || SQLERRM);
  END;

  -- 13. PBB table
  BEGIN
    SELECT COUNT(*) INTO v_exists 
    FROM user_sequences WHERE sequence_name = 'SEQ_PBB_ID';
    
    IF v_exists = 0 THEN
      SELECT NVL(MAX(ID), 0) INTO v_max_id FROM PBB;
      v_sql := 'CREATE SEQUENCE SEQ_PBB_ID START WITH ' || (v_max_id + 1) || ' INCREMENT BY 1 NOCACHE NOCYCLE';
      EXECUTE IMMEDIATE v_sql;
      DBMS_OUTPUT.PUT_LINE('✓ SEQ_PBB_ID created starting from ' || (v_max_id + 1));
    ELSE
      DBMS_OUTPUT.PUT_LINE('⚠ SEQ_PBB_ID already exists');
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('✗ Error creating SEQ_PBB_ID: ' || SQLERRM);
  END;

  -- 14. PERIOD table
  BEGIN
    SELECT COUNT(*) INTO v_exists 
    FROM user_sequences WHERE sequence_name = 'SEQ_PERIOD_ID';
    
    IF v_exists = 0 THEN
      SELECT NVL(MAX(ID), 0) INTO v_max_id FROM PERIOD;
      v_sql := 'CREATE SEQUENCE SEQ_PERIOD_ID START WITH ' || (v_max_id + 1) || ' INCREMENT BY 1 NOCACHE NOCYCLE';
      EXECUTE IMMEDIATE v_sql;
      DBMS_OUTPUT.PUT_LINE('✓ SEQ_PERIOD_ID created starting from ' || (v_max_id + 1));
    ELSE
      DBMS_OUTPUT.PUT_LINE('⚠ SEQ_PERIOD_ID already exists');
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('✗ Error creating SEQ_PERIOD_ID: ' || SQLERRM);
  END;

  -- 15. PERIOD_REQUEST table
  BEGIN
    SELECT COUNT(*) INTO v_exists 
    FROM user_sequences WHERE sequence_name = 'SEQ_PERIOD_REQUEST_ID';
    
    IF v_exists = 0 THEN
      SELECT NVL(MAX(ID), 0) INTO v_max_id FROM PERIOD_REQUEST;
      v_sql := 'CREATE SEQUENCE SEQ_PERIOD_REQUEST_ID START WITH ' || (v_max_id + 1) || ' INCREMENT BY 1 NOCACHE NOCYCLE';
      EXECUTE IMMEDIATE v_sql;
      DBMS_OUTPUT.PUT_LINE('✓ SEQ_PERIOD_REQUEST_ID created starting from ' || (v_max_id + 1));
    ELSE
      DBMS_OUTPUT.PUT_LINE('⚠ SEQ_PERIOD_REQUEST_ID already exists');
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('✗ Error creating SEQ_PERIOD_REQUEST_ID: ' || SQLERRM);
  END;

  -- 16. PICTUREASSETS table
  BEGIN
    SELECT COUNT(*) INTO v_exists 
    FROM user_sequences WHERE sequence_name = 'SEQ_PICTUREASSETS_ID';
    
    IF v_exists = 0 THEN
      SELECT NVL(MAX(ID), 0) INTO v_max_id FROM PICTUREASSETS;
      v_sql := 'CREATE SEQUENCE SEQ_PICTUREASSETS_ID START WITH ' || (v_max_id + 1) || ' INCREMENT BY 1 NOCACHE NOCYCLE';
      EXECUTE IMMEDIATE v_sql;
      DBMS_OUTPUT.PUT_LINE('✓ SEQ_PICTUREASSETS_ID created starting from ' || (v_max_id + 1));
    ELSE
      DBMS_OUTPUT.PUT_LINE('⚠ SEQ_PICTUREASSETS_ID already exists');
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('✗ Error creating SEQ_PICTUREASSETS_ID: ' || SQLERRM);
  END;

  -- 17. REFERENCES table
  BEGIN
    SELECT COUNT(*) INTO v_exists 
    FROM user_sequences WHERE sequence_name = 'SEQ_REFERENCES_ID';
    
    IF v_exists = 0 THEN
      SELECT NVL(MAX(ID), 0) INTO v_max_id FROM REFERENCES;
      v_sql := 'CREATE SEQUENCE SEQ_REFERENCES_ID START WITH ' || (v_max_id + 1) || ' INCREMENT BY 1 NOCACHE NOCYCLE';
      EXECUTE IMMEDIATE v_sql;
      DBMS_OUTPUT.PUT_LINE('✓ SEQ_REFERENCES_ID created starting from ' || (v_max_id + 1));
    ELSE
      DBMS_OUTPUT.PUT_LINE('⚠ SEQ_REFERENCES_ID already exists');
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('✗ Error creating SEQ_REFERENCES_ID: ' || SQLERRM);
  END;

  -- 18. ROLES table
  BEGIN
    SELECT COUNT(*) INTO v_exists 
    FROM user_sequences WHERE sequence_name = 'SEQ_ROLES_ID';
    
    IF v_exists = 0 THEN
      SELECT NVL(MAX(ID), 0) INTO v_max_id FROM ROLES;
      v_sql := 'CREATE SEQUENCE SEQ_ROLES_ID START WITH ' || (v_max_id + 1) || ' INCREMENT BY 1 NOCACHE NOCYCLE';
      EXECUTE IMMEDIATE v_sql;
      DBMS_OUTPUT.PUT_LINE('✓ SEQ_ROLES_ID created starting from ' || (v_max_id + 1));
    ELSE
      DBMS_OUTPUT.PUT_LINE('⚠ SEQ_ROLES_ID already exists');
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('✗ Error creating SEQ_ROLES_ID: ' || SQLERRM);
  END;

  -- 19. USERS table
  BEGIN
    SELECT COUNT(*) INTO v_exists 
    FROM user_sequences WHERE sequence_name = 'SEQ_USERS_ID';
    
    IF v_exists = 0 THEN
      SELECT NVL(MAX(ID), 0) INTO v_max_id FROM USERS;
      v_sql := 'CREATE SEQUENCE SEQ_USERS_ID START WITH ' || (v_max_id + 1) || ' INCREMENT BY 1 NOCACHE NOCYCLE';
      EXECUTE IMMEDIATE v_sql;
      DBMS_OUTPUT.PUT_LINE('✓ SEQ_USERS_ID created starting from ' || (v_max_id + 1));
    ELSE
      DBMS_OUTPUT.PUT_LINE('⚠ SEQ_USERS_ID already exists');
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('✗ Error creating SEQ_USERS_ID: ' || SQLERRM);
  END;

  -- 20. USES table
  BEGIN
    SELECT COUNT(*) INTO v_exists 
    FROM user_sequences WHERE sequence_name = 'SEQ_USES_ID';
    
    IF v_exists = 0 THEN
      SELECT NVL(MAX(ID), 0) INTO v_max_id FROM USES;
      v_sql := 'CREATE SEQUENCE SEQ_USES_ID START WITH ' || (v_max_id + 1) || ' INCREMENT BY 1 NOCACHE NOCYCLE';
      EXECUTE IMMEDIATE v_sql;
      DBMS_OUTPUT.PUT_LINE('✓ SEQ_USES_ID created starting from ' || (v_max_id + 1));
    ELSE
      DBMS_OUTPUT.PUT_LINE('⚠ SEQ_USES_ID already exists');
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('✗ Error creating SEQ_USES_ID: ' || SQLERRM);
  END;

  DBMS_OUTPUT.PUT_LINE('========================================================');
  DBMS_OUTPUT.PUT_LINE('Sequence creation process completed!');
  DBMS_OUTPUT.PUT_LINE('Note: Sequences that already exist were skipped.');
  DBMS_OUTPUT.PUT_LINE('========================================================');
  
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('✗ Fatal error: ' || SQLERRM);
    RAISE;
END;