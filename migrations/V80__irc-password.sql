ALTER TABLE login add column irc_password VARCHAR(20);
CREATE TRIGGER before_insert_login
  BEFORE INSERT ON login
  FOR EACH ROW
  SET new.irc_password = LEFT(UUID(), 20);

-- without the trigger all passwords are the same because of caching the value of uuid() function
create trigger uniqueUuidTrigger  BEFORE UPDATE on login
FOR EACH ROW
BEGIN
  SET new.irc_password := (SELECT LEFT(CONCAT(UUID()), 20));
END;

UPDATE login set login.irc_password = LEFT(CONCAT(UUID()), 20);

drop trigger uniqueUuidTrigger;