-- Create table
create table PRODUCTS
(
  product_id          number not null,
  product_name        nvarchar2(300) not null,
  quant_identificator nvarchar2(20) not null,
  unit_price          number not null,
  quantity            number not null
)
;
-- Create/Recreate primary, unique and foreign key constraints 
alter table PRODUCTS
  add constraint p_product_id_primary primary key (PRODUCT_ID);
