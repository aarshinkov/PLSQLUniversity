-- Create table
create table BRANCHES
(
  branch_id   number not null,
  city        nvarchar2(100) not null,
  branch_size char(1) default 'S' not null,
  is_special  char(1) default 'N' not null
)
;
-- Add comments to the columns 
comment on column BRANCHES.branch_size
  is 'S - small; M - medium; L - large;';
-- Create/Recreate primary, unique and foreign key constraints 
alter table BRANCHES
  add constraint b_branch_id primary key (BRANCH_ID);
