-- Create table
create table QUESTIONABLE_TRADERS
(
  trader_id     number not null,
  status        char(1) not null,
  date_of_event date default sysdate not null
)
;
-- Add comments to the columns 
comment on column QUESTIONABLE_TRADERS.status
  is 'D - dubious; M - malicious';
comment on column QUESTIONABLE_TRADERS.date_of_event
  is 'Date from which a user is treated questionable';
-- Create/Recreate primary, unique and foreign key constraints 
alter table QUESTIONABLE_TRADERS
  add constraint qt_trader_id_primary primary key (TRADER_ID);
alter table QUESTIONABLE_TRADERS
  add constraint qt_trader_id_foreign foreign key (TRADER_ID)
  references traders (TRADER_ID) on delete cascade;
