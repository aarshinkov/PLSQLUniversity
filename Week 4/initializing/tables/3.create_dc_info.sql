-- Create table
create table DC_INFO
(
  card_id     nvarchar2(15) not null,
  card_amount number not null
)
;
-- Create/Recreate primary, unique and foreign key constraints 
alter table DC_INFO
  add constraint dc_info_card_id_primary primary key (CARD_ID);
