/**
 * Migration Description: 
 * 
 *
 * Rollback Instructions: 
 *
 *
 **/

DO LANGUAGE plpgsql $$
DECLARE
	SCRIPT_NAME varchar := 'INSERT_SCRIPT_NAME_HERE';
	SCRIPT_COUNT integer := (select COUNT(*) from schema_migration WHERE filename=SCRIPT_NAME);
BEGIN 
	IF (SCRIPT_COUNT > 0) 
	THEN RAISE NOTICE 'SKIPPING MIGRATION';
	ELSE BEGIN
		RAISE NOTICE 'RUNNING MIGRATION';
		/* START YOUR MIGRATION HERE */
		
		
		/* END YOUR MIGRATION HERE */
		RAISE NOTICE 'FINISHED MIGRATION';
		INSERT INTO schema_migration(filename) VALUES(SCRIPT_NAME);
	END;
	END IF;
END $$;