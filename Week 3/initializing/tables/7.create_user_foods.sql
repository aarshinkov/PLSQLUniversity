-- Create table
create table USER_FOODS
(
  user_foods_id number not null,
  user_id       number not null,
  food_name     nvarchar2(50) not null,
  quantity      number default 1 not null
)
;
-- Create/Recreate primary, unique and foreign key constraints 
alter table USER_FOODS
  add constraint uf_user_foods_id_primary primary key (USER_FOODS_ID);
alter table USER_FOODS
  add constraint uf_user_id_foreign foreign key (USER_ID)
  references users (USER_ID) on delete cascade;
alter table USER_FOODS
  add constraint uf_food_name_foreign foreign key (FOOD_NAME)
  references foods (FOOD_NAME);
