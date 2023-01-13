-- Create table
create table ERROR_REGISTRY
(
  error_id   number not null,
  error_date date default sysdate not null,
  type       nvarchar2(50) not null,
  descr      nvarchar2(300) not null
)
;
-- Add comments to the columns 
comment on column ERROR_REGISTRY.type
  is 'Custom error code';
-- Create/Recreate primary, unique and foreign key constraints 
alter table ERROR_REGISTRY
  add constraint e_error_id_primary primary key (ERROR_ID);
