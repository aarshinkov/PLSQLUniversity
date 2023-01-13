-- Create table
create table ACCOUNTS
(
  account_id    number not null,
  account_name  nvarchar2(200),
  balance       number default 0 not null,
  currency_type nvarchar2(20) default 'BGN' not null,
  customer_id   number not null,
)
;
-- Add comments to the columns 
comment on column ACCOUNTS.customer_id
  is 'Customer linked to this account';
-- Create/Recreate primary, unique and foreign key constraints 
alter table ACCOUNTS
  add constraint acc_account_id_primary primary key (ACCOUNT_ID);
alter table ACCOUNTS
  add constraint acc_cust_id_foreign foreign key (CUSTOMER_ID)
  references customers (CUSTOMER_ID) on delete cascade;
