-- Create table
create table INVENTORY_BOOKS
(
  product_id    number not null,
  creation_date date default sysdate not null,
  trader_id     number not null
)
;
-- Create/Recreate primary, unique and foreign key constraints 
alter table INVENTORY_BOOKS
  add constraint ib_pdt_primary primary key (PRODUCT_ID, CREATION_DATE, TRADER_ID);
alter table INVENTORY_BOOKS
  add constraint ib_trader_id_foreign foreign key (TRADER_ID)
  references traders (TRADER_ID);
