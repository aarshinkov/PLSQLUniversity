-- Create table
create table ROOMS
(
  room_id   number not null,
  castle_id number not null,
  stars     number not null
)
;

-- Create/Recreate primary, unique and foreign key constraints 
alter table ROOMS
  add constraint r_room_id_primary primary key (ROOM_ID);
alter table ROOMS
  add constraint r_castle_id_foreign foreign key (CASTLE_ID)
  references castles (CASTLE_ID) on delete cascade;
