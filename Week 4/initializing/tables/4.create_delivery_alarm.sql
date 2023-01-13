-- Create table
create table DELIVERY_ALARM
(
  delivery_alarm_id number not null,
  prod_id           number not null,
  prod_quantity     number not null,
  branch_id         number not null
)
;
-- Create/Recreate primary, unique and foreign key constraints 
alter table DELIVERY_ALARM
  add constraint da_delivery_alarm_id_primary primary key (DELIVERY_ALARM_ID);
alter table DELIVERY_ALARM
  add constraint da_prod_id_foreign foreign key (PROD_ID)
  references products (PROD_ID) on delete cascade;
alter table DELIVERY_ALARM
  add constraint da_branch_id_foreign foreign key (BRANCH_ID)
  references branches (BRANCH_ID) on delete cascade;
