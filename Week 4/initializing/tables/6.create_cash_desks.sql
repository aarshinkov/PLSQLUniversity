-- Create table
create table CASH_DESKS
(
  branch_id number not null,
  balance   number default 100 not null
)
;
-- Create/Recreate primary, unique and foreign key constraints 
alter table CASH_DESKS
  add constraint cd_branch_id_primary primary key (BRANCH_ID);
alter table CASH_DESKS
  add constraint cd_branch_id_foreign foreign key (BRANCH_ID)
  references branches (BRANCH_ID) on delete cascade;
