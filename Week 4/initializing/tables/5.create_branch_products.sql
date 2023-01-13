-- Create table
create table BRANCH_PRODUCTS
(
  branch_products_id number not null,
  prod_id            number not null,
  branch_id          number not null,
  avail_quant        number default 1 not null
)
;
-- Create/Recreate primary, unique and foreign key constraints 
alter table BRANCH_PRODUCTS
  add constraint bp_branch_products_id_primary primary key (BRANCH_PRODUCTS_ID);
alter table BRANCH_PRODUCTS
  add constraint bp_prod_id_foreign foreign key (PROD_ID)
  references products (PROD_ID) on delete cascade;
alter table BRANCH_PRODUCTS
  add constraint bp_branch_id_foreign foreign key (BRANCH_ID)
  references branches (BRANCH_ID) on delete cascade;
alter table BRANCH_PRODUCTS
  add constraint BP_PROD_BRANCH_UNIQUE unique (PROD_ID, BRANCH_ID);
