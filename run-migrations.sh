# Run migration scripts in alphabetical order against a remote postgres database

# Loop through migrations (quitting if one fails)
set -e
for FILE in `ls ./migrations/*.sql | sort -g`; 
do
	# Build Script File, auto-embedding script filename and db schema name
	echo "\n\n---------------------------------------------------------"
	echo RUNNING MIGRATION $FILE
	echo "SET search_path TO $PSQL_SCHEMA;" > temp.sql
	cat $FILE >> temp.sql
	sed -i "s/INSERT_SCRIPT_NAME_HERE/$FILE/g" temp.sql || true

	# Run migration
	psql $PSQL_EXTRA_CLI_PARAMS --file=temp.sql
    rm -f temp.sql
	echo "DONE RUNNING MIGRATION $FILE\n"
done
