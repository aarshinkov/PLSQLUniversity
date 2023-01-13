-- Create table
create table EMPLOYEES
(
  employee_id   number not null,
  first_name    nvarchar2(150) not null,
  last_name     nvarchar2(150) not null,
  addit_name    nvarchar2(150),
  address       nvarchar2(1000) not null,
  phone         nvarchar2(40) not null,
  email         nvarchar2(100) not null,
  hire_date     date not null,
  status        number default 1 not null,
  position      nvarchar2(50) not null,
  salary        number not null,
  department_id number,
  manager_id    number
)
;
-- Add comments to the columns 
comment on column EMPLOYEES.status
  is '1 - working; 2 - holiday/ill; 3 - motherhood; 4 - fired';
comment on column EMPLOYEES.department_id
  is 'The department customer is working in';
comment on column EMPLOYEES.manager_id
  is 'Id of the manager of the employee';
-- Create/Recreate primary, unique and foreign key constraints 
alter table EMPLOYEES
  add constraint empl_employee_id_primary primary key (EMPLOYEE_ID);
alter table EMPLOYEES
  add constraint empl_dep_id_foreign foreign key (DEPARTMENT_ID)
  references departments (DEPARTMENT_ID) on delete set null;
alter table EMPLOYEES
  add constraint EMPL_MANAGER_ID_FOREIGN foreign key (MANAGER_ID)
  references employees (EMPLOYEE_ID) on delete set null;

