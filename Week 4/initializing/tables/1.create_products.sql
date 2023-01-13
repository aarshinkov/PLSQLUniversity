-- Create table
create table PRODUCTS
(
  prod_id    number not null,
  name       nvarchar2(105) not null,
  price      number not null,
  date_added date default sysdate not null
)
;
-- Create/Recreate primary, unique and foreign key constraints 
alter table PRODUCTS
  add constraint p_prod_id_primary primary key (PROD_ID);
