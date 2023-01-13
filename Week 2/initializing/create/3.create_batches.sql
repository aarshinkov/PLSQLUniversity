-- Create table
create table BATCHES
(
  batch_id      number,
  trader_id     number not null,
  balance       number default 0 not null,
  creation_date date default sysdate not null
)
;
-- Create/Recreate primary, unique and foreign key constraints 
alter table BATCHES
  add constraint b_batch_id_primary primary key (BATCH_ID);
alter table BATCHES
  add constraint b_id_date_unique unique (BATCH_ID, CREATION_DATE);
