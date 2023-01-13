-- Create table
create table CUSTOMERS
(
  customer_id number not null,
  first_name  nvarchar2(150) not null,
  last_name   nvarchar2(150) not null,
  addit_name  nvarchar2(150),
  address     nvarchar2(1000) not null,
  phone       nvarchar2(40) not null,
  email       nvarchar2(100) not null
)
;
-- Create/Recreate primary, unique and foreign key constraints 
alter table CUSTOMERS
  add constraint cust_customer_id_primary primary key (CUSTOMER_ID);
