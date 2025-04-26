DECLARE
  PROCEDURE drop_sequence_if_exists(p_sequence_name IN VARCHAR2) IS
  BEGIN
    EXECUTE IMMEDIATE 'DROP SEQUENCE ' || p_sequence_name;
  EXCEPTION
    WHEN OTHERS THEN
      IF SQLCODE != -2289 THEN
        DBMS_OUTPUT.PUT_LINE('Error dropping sequence ' || p_sequence_name || ': ' || SQLERRM);
      END IF;
  END;
BEGIN
  drop_sequence_if_exists('"ASSET_SAP_FAILED_SEQ"');
  drop_sequence_if_exists('"FAILED_JOBS_ID_SEQ"');
  drop_sequence_if_exists('"GROUPASSETS_ID_SEQ"');
  drop_sequence_if_exists('"GROUPCLASSES_ID_SEQ"');
  drop_sequence_if_exists('"MASTER_ASURANSI_SEQ"');
  drop_sequence_if_exists('"MIGRATIONS_ID_SEQ"');
  drop_sequence_if_exists('"MONITORING_FAILED_SEQ"');
  drop_sequence_if_exists('"MONITORING_INTEGRATOR_SEQ"');
  drop_sequence_if_exists('"NOTIFIKASI_SEQ"');
  drop_sequence_if_exists('"PERIOD_REQUEST_SEQ"');
  drop_sequence_if_exists('"PERIOD_SEQ"');
  drop_sequence_if_exists('"REFERENCE_ID_SEQ"');
  drop_sequence_if_exists('"USERS_ID_SEQ"');
END;
/
