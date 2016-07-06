/*

Briefly explain what the script does here.

*/

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
SET sql_mode='NO_AUTO_VALUE_ON_ZERO';

DELIMITER //
DROP PROCEDURE IF EXISTS fail_or_finish //
CREATE PROCEDURE fail_or_finish ()
BEGIN
    IF tap.num_failed() > 0 THEN
        ROLLBACK;
        SELECT `Tests failed`;
    ELSE
        CALL tap.finish();
        ROLLBACK TO after_migration;
        COMMIT;
    END IF;
END //
DELIMITER ;
-- Start of DDL statements


    -- DDL statements implicitly commit transactions, therefore they need to be placed here


-- End of DDL statements
START TRANSACTION;
-- Start of DML statements


    -- Insert migration code here. Use only DML (insert, update, delete) OTHERWISE YOU'LL COMMIT THE TRANSACTION!


-- End of DML statements
SAVEPOINT after_migration
-- Start of verification code
    SELECT plan(1); -- the number of tests to be executed

    -- Insert tests here. Read https://github.com/theory/mytap;


-- End of verification code
CALL fail_or_finish();
-- Start of DDL statements


    -- Drop any tables here


-- End of DDL statements


/*!40101 SET character_set_client = @saved_cs_client */;
