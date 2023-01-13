-- Create table
create table DEPARTMENTS
(
  department_id   number not null,
  department_name nvarchar2(150) not null
)
;
-- Create/Recreate primary, unique and foreign key constraints 
alter table DEPARTMENTS
  add constraint dep_dep_id_primary primary key (DEPARTMENT_ID);
