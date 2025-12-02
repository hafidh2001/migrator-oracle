-- Check for duplicate ASSETS records
SELECT
    NO_ASET,
    SUB_ASET,
    PERIODE,
    TAHUN,
    COUNT(*) as duplicate_count
FROM ASSETS
GROUP BY NO_ASET, SUB_ASET, PERIODE, TAHUN
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC
FETCH FIRST 20 ROWS ONLY;
