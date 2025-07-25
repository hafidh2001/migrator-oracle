BEGIN
  EXECUTE IMMEDIATE'
    DELETE FROM ASSETS
    WHERE ROWID IN (
        SELECT rid FROM (
            SELECT
                ROWID AS rid,
                ROW_NUMBER() OVER (
                    PARTITION BY NO_ASET, SUB_ASET, NAMA_ASET
                    ORDER BY ROWID
                ) AS rn
            FROM ASSETS
        )
        WHERE rn > 1
    );
  ';

  DBMS_OUTPUT.PUT_LINE('✅ Removed duplicate records from ASSETS table');
END;