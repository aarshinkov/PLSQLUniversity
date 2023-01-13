-- Create table
create table TRADERS
(
  trader_id   number not null,
  trader_type char(1) not null,
  trader_name nvarchar2(150) not null
)
;
-- Add comments to the columns 
comment on column TRADERS.trader_type
  is 'I - ''individual''; C - ''corporate''';
-- Create/Recreate primary, unique and foreign key constraints 
alter table TRADERS
  add constraint t_trader_id_primary primary key (TRADER_ID);
