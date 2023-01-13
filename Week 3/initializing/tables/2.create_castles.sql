-- Create table
create table CASTLES
(
  castle_id number not null,
  user_id   number not null
)
;
-- Create/Recreate primary, unique and foreign key constraints 
alter table CASTLES
  add constraint ca_castle_id_primary primary key (CASTLE_ID);
alter table CASTLES
  add constraint ca_user_id_foreign foreign key (USER_ID)
  references users (USER_ID) on delete cascade;
