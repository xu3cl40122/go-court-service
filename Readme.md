## go-court-api 

### cmd
- backup db
`docker exec -t {container_id}  pg_dumpall -c -U postgres > dump.sql`
- import db
`cat dump.sql | docker exec -i {container_id} psql -U postgres`
- cd to container
`docker exec -it <mycontainer> bash`
- run psql on container
`docker exec -it mydb psql -U postgres -d your_database`
- import csv to table 
`\COPY court FROM '/var/lib/postgresql/data/court.csv' DELIMITER ',' CSV HEADER;`


### db 
- foreign key
``` sql
alter table game 
  add column court_id integer, 
  add constraint court_constraint
  foreign key (court_id) 
  references court (court_id);
```



### 遇過的問題

- backup db 
- gcp storage 權限
- import csv to table 
- winodws 要開 docker volume share 權限