## go-court-api 

### cmd
- backup db
`docker exec -t {container_id}  pg_dumpall -c -U postgres > dump.sql`
- import db
`cat dump.sql | docker exec -i {container_id} psql -U postgres`
- cd to container
`docker exec -it <mycontainer> sh`
- run psql on container
`docker exec -it mydb psql -U postgres -d your_database`
- import csv to table 
`\COPY court FROM '/var/lib/postgresql/data/court.csv' DELIMITER ',' CSV HEADER;`
- set postgis column 
`ALTER TABLE your_table ADD COLUMN geom geometry(Point, 4326);`
`UPDATE your_table SET geom = ST_SetSRID(ST_MakePoint(longitude, latitude), 4326);`
- ssh to ec2 
`ssh -i {path of key} ubuntu@ec2-34-219-47-37.us-west-2.compute.amazonaws.com`
- run compose limit cpu 
`docker-compose --compatibility up -d`
- move file to ec2
`scp -i {path of key} -r {file path}  ec2-user@ec2-52-11-194-84.us-west-2.compute.amazonaws.com:{target path}`



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
- ssh key 權限太公開 https://blog.csdn.net/joshua2011/article/details/90208741
- nginx lets encrypt