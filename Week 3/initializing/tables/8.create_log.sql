-- Create table
create table LOG
(
  log_id   number not null,
  log_code nvarchar2(45) not null,
  log_date date default sysdate not null
)
;
-- Create/Recreate primary, unique and foreign key constraints 
alter table LOG
  add constraint l_log_id_primary primary key (LOG_ID);
