-- Create table
create table CATS
(
  cat_id    number not null,
  user_id   number not null,
  name      nvarchar2(105) not null,
  fur_color nvarchar2(30) not null,
  weight    number not null,
  type      char(1) default 'S' not null,
  cat_level number default 1 not null,
  room_id   number not null
)
;
-- Add comments to the columns 
comment on column CATS.user_id
  is 'Id of the owner user';
comment on column CATS.type
  is 'S - small; M - medium; L - large';
comment on column CATS.room_id
  is 'ID of the room that cat lives in';
-- Create/Recreate primary, unique and foreign key constraints 
alter table CATS
  add constraint c_cat_id_primary primary key (CAT_ID);
alter table CATS
  add constraint c_user_id_foreign foreign key (USER_ID)
  references users (USER_ID) on delete set null;
alter table CATS
  add constraint c_room_id_foreign foreign key (ROOM_ID)
  references rooms (ROOM_ID) on delete cascade;
