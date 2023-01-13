-- Create table
create table FOODS
(
  food_name  nvarchar2(50) not null,
  unit_price number not null
)
;
-- Create/Recreate primary, unique and foreign key constraints 
alter table FOODS
  add constraint f_food_name_primary primary key (FOOD_NAME);
