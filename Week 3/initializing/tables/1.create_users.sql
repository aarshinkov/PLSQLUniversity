-- Create table
create table USERS
(
  user_id    number not null,
  identifier nvarchar2(20),
  first_name nvarchar2(105) not null,
  last_name  nvarchar2(105) not null,
  email      nvarchar2(105) not null,
  password   nvarchar2(105) not null,
  balance    number default 0 not null
)
;
-- Create/Recreate primary, unique and foreign key constraints 
alter table USERS
  add constraint u_user_id_primary primary key (USER_ID);
alter table USERS
  add constraint u_email_unique unique (EMAIL);
