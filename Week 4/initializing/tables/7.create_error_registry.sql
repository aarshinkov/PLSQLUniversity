-- Create table
create table ERROR_REGISTRY
(
  error_id   number not null,
  error_code nvarchar2(50) not null,
  error_date date default sysdate not null
)
;
-- Create/Recreate primary, unique and foreign key constraints 
alter table ERROR_REGISTRY
  add constraint er_error_id_primary primary key (ERROR_ID);
