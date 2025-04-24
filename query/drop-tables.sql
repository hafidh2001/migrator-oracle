DECLARE
   PROCEDURE drop_if_exists(p_table_name IN VARCHAR2) IS
   BEGIN
      EXECUTE IMMEDIATE 'DROP TABLE "C##SIAPDEV4"."' || p_table_name || '" CASCADE CONSTRAINTS';
   EXCEPTION
      WHEN OTHERS THEN
         IF SQLCODE != -942 THEN
            DBMS_OUTPUT.PUT_LINE('Error dropping ' || p_table_name || ': ' || SQLERRM);
         END IF;
   END;
BEGIN
   drop_if_exists('ASSETACCOUNTS');
   drop_if_exists('ASSETCLASSES');
   drop_if_exists('ASSETS');
   drop_if_exists('ASSET_SAP_FAILED');
   drop_if_exists('BRANCHES');
   drop_if_exists('COSTCENTERS');
   drop_if_exists('DEPRECIATIONS');
   drop_if_exists('DEPRECIATION_VALUES');
   drop_if_exists('DETAILASSETS');
   drop_if_exists('DIMENSI_SATUAN');
   drop_if_exists('ELIMINATION');
   drop_if_exists('GROUPASSETS');
   drop_if_exists('GROUPCLASSES');
   drop_if_exists('INSURANCES');
   drop_if_exists('MASTER_ASURANSI');
   drop_if_exists('NOTIFIKASI');
   drop_if_exists('PBB');
   drop_if_exists('PERIOD');
   drop_if_exists('PERIOD_REQUEST');
   drop_if_exists('PICTUREASSETS');
   drop_if_exists('REFERENCES');
   drop_if_exists('ROLES');
   drop_if_exists('USERS');
   drop_if_exists('USES');
   DBMS_OUTPUT.PUT_LINE('Tables dropped successfully');
END;
