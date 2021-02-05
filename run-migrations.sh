# Run migration scripts in alphabetical order against a remote mysql database

# Loop through migrations (quitting if one fails)
set -e
for FILE in `ls ./migrations/*.sql | sort -g`; 
do
	# Build Script File, auto-embedding script filename and db schema name
	echo "\n\n---------------------------------------------------------"
	echo RUNNING MIGRATION $FILE
	rm -f temp.sql
	rm -f tempbuffer.sql
	echo "SET search_path TO $PSQL_SCHEMA;" > tempbuffer.sql
	cat $FILE >> tempbuffer.sql
	sed "s+INSERT_SCRIPT_NAME_HERE+$FILE+g" tempbuffer.sql > temp.sql

	# Run migration
	psql $PSQL_EXTRA_CLI_PARAMS --file=temp.sql
	rm -f temp.sql
	rm -f tempbuffer.sql
	echo "DONE RUNNING MIGRATION $FILE\n"
done
