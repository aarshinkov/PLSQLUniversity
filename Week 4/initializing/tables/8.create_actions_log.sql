-- Create table
create table ACTIONS_LOG
(
  action_log_id number not null,
  action_date   date default sysdate not null,
  description   nvarchar2(500) not null
)
;
-- Create/Recreate primary, unique and foreign key constraints 
alter table ACTIONS_LOG
  add constraint al_action_log_id_primary primary key (ACTION_LOG_ID);
