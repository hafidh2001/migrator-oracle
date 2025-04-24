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
  drop_sequence_if_exists('"C##SIAPDEV4"."ASSET_SAP_FAILED_SEQ"');
  drop_sequence_if_exists('"C##SIAPDEV4"."FAILED_JOBS_ID_SEQ"');
  drop_sequence_if_exists('"C##SIAPDEV4"."GROUPASSETS_ID_SEQ"');
  drop_sequence_if_exists('"C##SIAPDEV4"."GROUPCLASSES_ID_SEQ"');
  drop_sequence_if_exists('"C##SIAPDEV4"."JOBS_SEQ"');
  drop_sequence_if_exists('"C##SIAPDEV4"."MASTER_ASURANSI_SEQ"');
  drop_sequence_if_exists('"C##SIAPDEV4"."MIGRATIONS_ID_SEQ"');
  drop_sequence_if_exists('"C##SIAPDEV4"."MONITORING_FAILED_SEQ"');
  drop_sequence_if_exists('"C##SIAPDEV4"."MONITORING_INTEGRATOR_SEQ"');
  drop_sequence_if_exists('"C##SIAPDEV4"."NOTIFIKASI_SEQ"');
  drop_sequence_if_exists('"C##SIAPDEV4"."PERIOD_REQUEST_SEQ"');
  drop_sequence_if_exists('"C##SIAPDEV4"."PERIOD_SEQ"');
  drop_sequence_if_exists('"C##SIAPDEV4"."REFERENCE_ID_SEQ"');
  drop_sequence_if_exists('"C##SIAPDEV4"."USERS_ID_SEQ"');
END;
/
