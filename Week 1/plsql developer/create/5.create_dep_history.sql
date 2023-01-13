-- Create table
create table DEP_HISTORY
(
  action_id     number not null,
  employee_id   number not null,
  department_id number not null,
  action_date   date default sysdate not null
)
;
-- Add comments to the columns 
comment on column DEP_HISTORY.action_date
  is 'Date of the event';
-- Create/Recreate primary, unique and foreign key constraints 
alter table DEP_HISTORY
  add constraint dep_hist_action_id_primary primary key (ACTION_ID);
alter table DEP_HISTORY
  add constraint dep_hist_empl_id_foreign foreign key (EMPLOYEE_ID)
  references employees (EMPLOYEE_ID);
alter table DEP_HISTORY
  add constraint dep_hist_dep_id_foreign foreign key (DEPARTMENT_ID)
  references departments (DEPARTMENT_ID);
