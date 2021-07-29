INSERT INTO backer_levels
(level_id,name,minimum_pledge,reward_details,estimated_delivery)
VALUES
(1,"Stargazer",1,"Access to the Backer Challenge rewards","2022-08-01"),
(2,"Colony Cadet",25,"Digital Copy of the game, Backer-exclusive Wallpapers,
  Any completed rewards from the Backer's Challenge","2022-08-01");



INSERT INTO customers
(first_name,last_name,email_address,date_of_birth)
VALUES
("Johnathan","Frakes","riker@gmail.com","1952-08-19"),
("Mark","Hamill","hamillhimself@hotmail.com","1951-09-25");


INSERT INTO customer_backer_levels
VALUES
(2,1,"2019-12-10",36),
(3,2,"2020-01-13",55);


INSERT INTO orders
(customer_id,order_date)
VALUES
(1,"2020-11-20 23:59:30"),
(2,"2020-11-19 12:25:12"),
(2,"2020-11-20 02:11:11");


INSERT INTO versions
(version_id,store_name,platform_name,release_date,price)
VALUES
(1,"Steam","PC","2020-11-01",24.99),
(2,"Epic Games Store","PC","2020-11-10",24.99),
(3,"Nintendo Store","Nintendo Switch","2020-11-10",29.99);


INSERT INTO order_versions
(order_id,version_id)
VALUES
(1,2),
(2,1),
(3,3);


INSERT INTO employees
(role,first_name,last_name,phone_number,email_address,country,province_state,
city,street_address,postal_zip_code)
VALUES
("Game Director","James","Howlett","604-333-2214","jamesh@gmail.com","Canada",
"Alberta","Calgary","24519 Snow Ave.","G3F1I9"),
("Play Tester","Wesley","Crusher","817-224-8899","wesscience@gmail.com","USA",
"Wyoming","Jackson Hole","19812 Kanye Drive","18922");


INSERT INTO employee_versions
(version_id,employee_id,start_date)
VALUES
(1,2,"2020-01-02"),
(2,2,"2020-02-03");
