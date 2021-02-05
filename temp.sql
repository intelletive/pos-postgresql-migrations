SET search_path TO ;
create table if not exists schema_migration(
  filename varchar(256) primary key,
  date_ran TIMESTAMP DEFAULT NOW()
);
