create database s1831050017_hotel

go
use s1831050017_hotel
go


create table users
(
	users_account char(9) primary key,/*主键*/
	password char(9) ,
	age smallint,
	name char(20),
	sex char(2),
	id_card char(18),
	tel_number char(11),
	registration_time datetime,
	e_mail char(20),
	are_VIP int,
	VIP_account char(20),
	VIP_intergral char(256)
	
);

create table VIP
(
	VIP_account char(20) primary key,
	VIP_intergral char(256),
	/*foreign key(VIP_account)references users(VIP_account) 外键*/

);

create table administrators
(
	adm_account char(9) primary key,
	password char(9),
	name char(20),
	sex char(2),
	tel_number char(11),
	e_mail char(20)

);

create table room
(
	room_number char(50) primary key,
	room_type char(50),
	floors int,
	room_area float,
	room_price float,
	room_capacity int,
	order_or_not int
);

create table room_type
(
	room_number char(50) primary key,
	single_room int,
	double_room int,
	child_room int,
	special_room int,
	apartment_room int,
	business_room int,
	outdoor_room int,
	indoor_room int,
	corner_room int,
	foreign key(room_number)references room(room_number)
);

create table order_room_information
(
	order_number char(20) primary key,
	order_time datetime,
	room_number char(50),
	room_type char(50),
	room_price float,
	users_account char(9),
	foreign key(room_number)references room(room_number),
	foreign key(users_account)references users(users_account)
);

create table order_customer_information
(
	order_number char(20) primary key,
	check_in_data datetime,
	departure_data datetime,
	users_account char(9),
	team_numbers int,
	amount_purchase float,
	amount_paid float,
	foreign key(order_number)references order_room_information(order_number),
	foreign key(users_account)references users(users_account)
);

/*创建触发器，实现入住和退房时自动修改客房状态*/
create trigger room_in2
on order_room_information
after insert 
as
begin 
declare @room_number char
select @room_number = room_number from inserted
update room 
set order_or_not = 'yes'
where room_number =@room_number
print'success!'
end

create trigger room_in3
on order_room_information
after delete 
as
begin 
declare @room_number char
select @room_number = room_number from deleted
update room 
set order_or_not = 'yes'
where room_number =@room_number
print'success!'
end

insert into	order_room_information
values ('20191216002','2019.12.16','R101','188.8','1')

