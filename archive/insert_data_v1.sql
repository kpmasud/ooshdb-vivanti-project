-- Database: ooshdb

-- DROP DATABASE IF EXISTS ooshdb;

CREATE DATABASE ooshdb
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'C'
    LC_CTYPE = 'C'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

INSERT INTO shops (shop_id, shop_name, suburb, postcode, state) VALUES (1, 'Ooshman Greenway', 'Greenway', '2900', 'ACT');
INSERT INTO shops (shop_id, shop_name, suburb, postcode, state) VALUES (2, 'Ooshman Weston', 'Weston ', '2611', 'ACT');
INSERT INTO shops (shop_id, shop_name, suburb, postcode, state) VALUES (3, 'Ooshman Gungahlin ', 'Gungahlin ', '2912', 'ACT');


select * from shops;



INSERT INTO payment_methods (payment_id, payment_method_name) VALUES (1, 'Cash');
INSERT INTO payment_methods (payment_id, payment_method_name) VALUES (2, 'PC Eftpos');
INSERT INTO payment_methods (payment_id, payment_method_name) VALUES (3, 'Mobile Eftpos');
INSERT INTO payment_methods (payment_id, payment_method_name) VALUES (4, 'Paid Online');


select * from payment_methods;

INSERT INTO delivery_methods (delivery_id, delivery_method_name) VALUES (1, 'Pickup');
INSERT INTO delivery_methods (delivery_id, delivery_method_name) VALUES (2, 'Delivery');
INSERT INTO delivery_methods (delivery_id, delivery_method_name) VALUES (3, 'Dine-In');


select * from delivery_methods;




INSERT INTO categories (category_id, category_name) VALUES (1, 'Deals');
INSERT INTO categories (category_id, category_name) VALUES (2, 'Breakfast');
INSERT INTO categories (category_id, category_name) VALUES (3, 'Manoosh');
INSERT INTO categories (category_id, category_name) VALUES (4, 'Wraps');
INSERT INTO categories (category_id, category_name) VALUES (5, 'Pizzas');
INSERT INTO categories (category_id, category_name) VALUES (6, 'Sandwiches');
INSERT INTO categories (category_id, category_name) VALUES (7, 'Kiddies');
INSERT INTO categories (category_id, category_name) VALUES (8, 'Fries');
INSERT INTO categories (category_id, category_name) VALUES (9, 'Teasers');
INSERT INTO categories (category_id, category_name) VALUES (10, 'Salads');
INSERT INTO categories (category_id, category_name) VALUES (11, 'Desserts');
INSERT INTO categories (category_id, category_name) VALUES (12, 'Drinks ');


select * from categories;



INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (1, 1, 'Two Salad Deal', 10.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (2, 1, 'Manoosh Combo', 14.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (3, 1, 'All Day Combo', 19.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (4, 1, 'Spicy Winter Deal', 44.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (5, 1, '1 Large Pizza Deal', 29.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (6, 1, '2 Large Pizza Deal', 49.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (7, 1, '3 Large Pizza Deal', 69.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (8, 1, 'Mega Feast', 99.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (9, 3, 'Zaatar', 3.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (10, 3, 'Lahembajin', 9.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (11, 3, 'Triple Cheese', 11.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (12, 3, 'Spinach & Cheese Pie', 10.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (13, 3, 'Haloumi Pie', 10.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (14, 3, 'Zaatar & Vegies', 8.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (15, 3, 'Zaatar Beirut Style', 9.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (16, 3, 'Zaatar & Cheese', 7.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (17, 3, 'Zaatar Deluxe', 12.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (18, 3, 'Lahembajin with Cheese', 12.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (19, 3, 'Lahembajin ‚Äì Tripoli Style', 14.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (20, 3, 'Sujuk Cuzzy', 14.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (21, 3, 'Captain Kafta', 14.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (22, 3, 'Chicken & Mushroom Boat', 12.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (23, 3, 'Sujuk & Egg Boat', 12.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (24, 3, 'Burrata Boat', 14.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (25, 4, 'Garlic Goddess', 14.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (26, 4, 'Flaming Peri Peri', 14.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (27, 4, 'Fully Tabouli', 14.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (28, 4, 'Habibi Yiros', 14.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (29, 4, 'Burger Kebab', 14.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (30, 5, 'Margarita', 18.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (31, 5, 'Pepperoni Burst', 19.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (33, 5, 'Hawaiian', 19.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (34, 5, 'Super Supreme', 23.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (35, 5, 'Meats Deluxe', 23.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (36, 5, 'Veggie Paradise', 22.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (37, 5, 'Oosh Garlic', 24.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (38, 5, 'Oosh Chilli', 24.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (39, 5, 'Oosh BBQ', 24.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (40, 5, 'Oosh Pesto', 24.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (41, 5, 'Half Half Pizza', 24.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (42, 6, 'Kafta Baba', 16.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (43, 6, 'Parmi Brother', 16.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (44, 6, 'Falafels Mama', 16.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (45, 7, 'Kids Cheese Pizza', 7.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (46, 7, 'Kids Pepperoni Pizza', 7.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (47, 7, 'Kids Ham & Pineapple Pizza', 7.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (48, 7, 'Chicken Nuggets & Chips', 8.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (49, 7, 'Lamb Kafta & Chips', 9.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (50, 8, 'Oosh Fries Regular', 4.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (51, 8, 'Oosh Fries Large', 6.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (52, 8, 'Oosh Fries Family', 12.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (53, 8, 'Lebo Fries', 9.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (54, 8, 'Cheesy Fries', 9.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (55, 8, 'Oosh Snack Pack', 14.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (56, 9, 'Rustic Loaf ‚Äì Garlic Butter', 5.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (57, 9, 'Rustic Loaf ‚Äì Chilli Garlic Butter', 5.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (58, 9, 'Rustic Loaf ‚Äì Garlic Toum', 5.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (59, 9, 'Avo Oosh-Oosh', 9.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (60, 9, 'Avocado Dip Platter', 10.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (61, 9, 'Garlic Dip Platter', 8.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (62, 9, 'Hommus Dip Platter', 8.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (63, 9, 'Labne Dip Platter', 8.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (64, 9, 'Crunchy Zaatar Chips', 3.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (65, 9, 'Southern Fried Tenders ‚Äì 3 Pack', 9.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (66, 9, 'Chicken Nuggets ‚Äì 10 Pack', 9.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (67, 9, 'Hot n Spicy Wings ‚Äì 4 Pack', 9.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (68, 9, 'Lamb Kebbeh ‚Äì 5 Pack', 11.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (69, 9, 'Cheesy Sambousik', 10.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (70, 9, 'Cheesy Balls ‚Äì 5 Pack', 11.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (71, 9, 'Lamb Kafta ‚Äì 5 Pack', 13.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (72, 9, 'Falafel ‚Äì 5 Pack', 10.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (73, 9, 'Garlic Prawns', 14.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (74, 10, 'Local Salad', 6.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (75, 10, 'Fatt-Oosh', 6.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (76, 10, 'Tabouli', 6.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (77, 10, 'Wild Rocket Salad', 6.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (78, 11, 'Nutella Nutella', 12.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (79, 11, 'Pistachio Delight', 12.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (80, 11, 'Biscoff Biscoff', 12.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (81, 11, 'Apple Pie Bites', 7.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (82, 11, 'Smashed Tiramisu', 8.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (83, 11, 'Creaming Mud Cake', 8.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (84, 12, 'Water 600ml', 3.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (85, 12, 'Sparkling Water 500ml', 4.50);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (86, 12, 'Pepsi 600ml', 4.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (87, 12, 'Pepsi Max 600ml', 4.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (88, 12, 'Solo 600ml', 4.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (89, 12, 'Mountain Dew 600ml', 4.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (90, 12, 'Lemonade 600ml', 4.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (91, 12, 'Sunkist Zero Sugar 600ml', 4.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (92, 12, 'Passiona 600ml', 4.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (93, 12, 'Schweppes Raspberry 600ml', 4.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (94, 12, 'Pop Tops Apple', 2.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (95, 12, 'Pop Tops Apple & Blackcurrant', 2.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (96, 12, 'Lipton Ice Tea Peach', 4.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (97, 12, 'Gatorade Blue Bolt', 4.95);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (98, 12, 'Spring Valley Orange Glass', 4.50);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (99, 12, 'Spring Valley Apple Glass', 4.50);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (100, 12, 'Solo Energy Zero Sugar 250ml', 4.50);
INSERT INTO menu_items (menu_item_id, category_id, menu_item_name, price) VALUES (101, 12, 'Solo Energy 250ml', 4.50);

select * from menu_items;

INSERT INTO staff (staff_id, shop_id, first_name, last_name, gender, role, date_of_birth, date_of_join, staff_mobile, staff_email) VALUES (401, 1, 'Emily', 'Emily', 'F', 'Manager', '1985-03-12', '2020-02-15', '413001001', 'emily.johnson@ooshman.com.au');
INSERT INTO staff (staff_id, shop_id, first_name, last_name, gender, role, date_of_birth, date_of_join, staff_mobile, staff_email) VALUES (402, 1, 'Liam', 'Liam', 'M', 'Pizza Maker', '1992-05-20', '2021-05-10', '413001002', 'liam.brown@ooshman.com.au');
INSERT INTO staff (staff_id, shop_id, first_name, last_name, gender, role, date_of_birth, date_of_join, staff_mobile, staff_email) VALUES (403, 1, 'Olivia', 'Olivia', 'F', 'Customer Service', '1995-07-02', '2022-01-20', '413001003', 'olivia.smith@ooshman.com.au');
INSERT INTO staff (staff_id, shop_id, first_name, last_name, gender, role, date_of_birth, date_of_join, staff_mobile, staff_email) VALUES (404, 1, 'Noah', 'Noah', 'M', 'Driver', '1988-09-15', '2021-08-03', '413001004', 'noah.wilson@ooshman.com.au');
INSERT INTO staff (staff_id, shop_id, first_name, last_name, gender, role, date_of_birth, date_of_join, staff_mobile, staff_email) VALUES (405, 1, 'Ava', 'Ava', 'F', 'Team Member', '1997-11-11', '2022-11-14', '413001005', 'ava.taylor@ooshman.com.au');
INSERT INTO staff (staff_id, shop_id, first_name, last_name, gender, role, date_of_birth, date_of_join, staff_mobile, staff_email) VALUES (406, 1, 'Jack', 'Jack', 'M', 'Kitchen Hand', '1993-04-25', '2023-07-05', '413001006', 'jack.williams@ooshman.com.au');
INSERT INTO staff (staff_id, shop_id, first_name, last_name, gender, role, date_of_birth, date_of_join, staff_mobile, staff_email) VALUES (407, 1, 'Isabella', 'Isabella', 'F', 'Shift Leader', '1996-10-08', '2020-10-12', '413001007', 'isabella.lee@ooshman.com.au');
INSERT INTO staff (staff_id, shop_id, first_name, last_name, gender, role, date_of_birth, date_of_join, staff_mobile, staff_email) VALUES (408, 1, 'Ethan', 'Ethan', 'M', 'All Rounder', '1991-06-30', '2021-04-18', '413001008', 'ethan.martin@ooshman.com.au');
INSERT INTO staff (staff_id, shop_id, first_name, last_name, gender, role, date_of_birth, date_of_join, staff_mobile, staff_email) VALUES (409, 1, 'Mia', 'Mia', 'F', 'Customer Service', '1994-02-22', '2022-08-22', '413001009', 'mia.white@ooshman.com.au');
INSERT INTO staff (staff_id, shop_id, first_name, last_name, gender, role, date_of_birth, date_of_join, staff_mobile, staff_email) VALUES (410, 1, 'Lucas', 'Lucas', 'M', 'Pizza Maker', '1987-11-25', '2019-09-25', '413001010', 'lucas.harris@ooshman.com.au');
INSERT INTO staff (staff_id, shop_id, first_name, last_name, gender, role, date_of_birth, date_of_join, staff_mobile, staff_email) VALUES (411, 2, 'Charlotte', 'Charlotte', 'F', 'Manager', '1993-03-15', '2020-03-12', '413001011', 'charlotte.clark@ooshman.com.au');
INSERT INTO staff (staff_id, shop_id, first_name, last_name, gender, role, date_of_birth, date_of_join, staff_mobile, staff_email) VALUES (412, 2, 'James', 'James', 'M', 'Team Member', '1990-12-05', '2021-05-18', '413001012', 'james.hall@ooshman.com.au');
INSERT INTO staff (staff_id, shop_id, first_name, last_name, gender, role, date_of_birth, date_of_join, staff_mobile, staff_email) VALUES (413, 2, 'Amelia', 'Amelia', 'F', 'Kitchen Hand', '1995-09-22', '2021-09-15', '413001013', 'amelia.lewis@ooshman.com.au');
INSERT INTO staff (staff_id, shop_id, first_name, last_name, gender, role, date_of_birth, date_of_join, staff_mobile, staff_email) VALUES (414, 2, 'Henry', 'Henry', 'M', 'Pizza Maker', '1989-07-09', '2020-07-20', '413001014', 'henry.young@ooshman.com.au');
INSERT INTO staff (staff_id, shop_id, first_name, last_name, gender, role, date_of_birth, date_of_join, staff_mobile, staff_email) VALUES (415, 2, 'Chloe', 'Chloe', 'F', 'Shift Leader', '1996-11-28', '2022-02-01', '413001015', 'chloe.evans@ooshman.com.au');
INSERT INTO staff (staff_id, shop_id, first_name, last_name, gender, role, date_of_birth, date_of_join, staff_mobile, staff_email) VALUES (416, 2, 'William', 'William', 'M', 'Driver', '1992-08-03', '2023-03-11', '413001016', 'william.scott@ooshman.com.au');
INSERT INTO staff (staff_id, shop_id, first_name, last_name, gender, role, date_of_birth, date_of_join, staff_mobile, staff_email) VALUES (417, 2, 'Isabella', 'Isabella', 'F', 'All Rounder', '1997-01-14', '2021-12-05', '413001017', 'isabella.green@ooshman.com.au');
INSERT INTO staff (staff_id, shop_id, first_name, last_name, gender, role, date_of_birth, date_of_join, staff_mobile, staff_email) VALUES (418, 2, 'Daniel', 'Daniel', 'M', 'Team Member', '1986-06-27', '2019-06-20', '413001018', 'daniel.adams@ooshman.com.au');
INSERT INTO staff (staff_id, shop_id, first_name, last_name, gender, role, date_of_birth, date_of_join, staff_mobile, staff_email) VALUES (419, 2, 'Grace', 'Grace', 'F', 'Customer Service', '1998-04-02', '2022-04-17', '413001019', 'grace.baker@ooshman.com.au');
INSERT INTO staff (staff_id, shop_id, first_name, last_name, gender, role, date_of_birth, date_of_join, staff_mobile, staff_email) VALUES (420, 2, 'Matthew', 'Matthew', 'M', 'Manager', '1994-10-21', '2020-11-09', '413001020', 'matthew.carter@ooshman.com.au');
INSERT INTO staff (staff_id, shop_id, first_name, last_name, gender, role, date_of_birth, date_of_join, staff_mobile, staff_email) VALUES (421, 3, 'Zoe', 'Zoe', 'F', 'Pizza Maker', '1993-01-11', '2020-01-19', '413001021', 'zoe.jenkins@ooshman.com.au');
INSERT INTO staff (staff_id, shop_id, first_name, last_name, gender, role, date_of_birth, date_of_join, staff_mobile, staff_email) VALUES (422, 3, 'Benjamin', 'Benjamin', 'M', 'Driver', '1991-05-27', '2021-05-02', '413001022', 'ben.kelly@ooshman.com.au');
INSERT INTO staff (staff_id, shop_id, first_name, last_name, gender, role, date_of_birth, date_of_join, staff_mobile, staff_email) VALUES (423, 3, 'Ella', 'Ella', 'F', 'Kitchen Hand', '1996-07-06', '2022-07-13', '413001023', 'ella.lopez@ooshman.com.au');
INSERT INTO staff (staff_id, shop_id, first_name, last_name, gender, role, date_of_birth, date_of_join, staff_mobile, staff_email) VALUES (424, 3, 'Michael', 'Michael', 'M', 'All Rounder', '1988-09-19', '2021-01-12', '413001024', 'michael.morris@ooshman.com.au');
INSERT INTO staff (staff_id, shop_id, first_name, last_name, gender, role, date_of_birth, date_of_join, staff_mobile, staff_email) VALUES (425, 3, 'Harper', 'Harper', 'F', 'Team Member', '1992-10-23', '2020-09-15', '413001025', 'harper.nelson@ooshman.com.au');
INSERT INTO staff (staff_id, shop_id, first_name, last_name, gender, role, date_of_birth, date_of_join, staff_mobile, staff_email) VALUES (426, 3, 'Jack', 'Jack', 'M', 'Customer Service', '1995-04-16', '2022-04-20', '413001026', 'jack.ortiz@ooshman.com.au');
INSERT INTO staff (staff_id, shop_id, first_name, last_name, gender, role, date_of_birth, date_of_join, staff_mobile, staff_email) VALUES (427, 3, 'Layla', 'Layla', 'F', 'Shift Leader', '1991-09-07', '2019-12-10', '413001027', 'layla.perez@ooshman.com.au');
INSERT INTO staff (staff_id, shop_id, first_name, last_name, gender, role, date_of_birth, date_of_join, staff_mobile, staff_email) VALUES (428, 3, 'David', 'David', 'M', 'Manager', '1987-11-11', '2019-06-14', '413001028', 'david.quinn@ooshman.com.au');
INSERT INTO staff (staff_id, shop_id, first_name, last_name, gender, role, date_of_birth, date_of_join, staff_mobile, staff_email) VALUES (429, 3, 'Aria', 'Aria', 'F', 'Pizza Maker', '1999-05-05', '2023-02-28', '413001029', 'aria.roberts@ooshman.com.au');
INSERT INTO staff (staff_id, shop_id, first_name, last_name, gender, role, date_of_birth, date_of_join, staff_mobile, staff_email) VALUES (430, 3, 'Thomas', 'Thomas', 'M', 'Driver', '1995-02-28', '2021-03-22', '413001030', 'thomas.stewart@ooshman.com.au');


select * from staff;




INSERT INTO customers (shop_id, customer_id, first_name, last_name, mobile, email, gender, date_of_birth, address) VALUES (1, 201, 'John', 'Smith', '412000001', 'john.smith1@email.com', 'Male', '1990-03-15', '12 Greenway St, Greenway');
INSERT INTO customers (shop_id, customer_id, first_name, last_name, mobile, email, gender, date_of_birth, address) VALUES (1, 202, 'Emily', 'Brown', '412000002', 'emily.brown2@email.com', 'Female', '1992-07-21', '45 Greenway Ave, Greenway');
INSERT INTO customers (shop_id, customer_id, first_name, last_name, mobile, email, gender, date_of_birth, address) VALUES (1, 203, 'Liam', 'Wilson', '412000003', 'liam.wilson3@email.com', 'Male', '1988-11-05', '88 Lake Rd, Greenway');
INSERT INTO customers (shop_id, customer_id, first_name, last_name, mobile, email, gender, date_of_birth, address) VALUES (1, 204, 'Olivia', 'Johnson', '412000004', 'olivia.johnson4@email.com', 'Female', '1995-06-19', '22 Lakeview Dr, Greenway');
INSERT INTO customers (shop_id, customer_id, first_name, last_name, mobile, email, gender, date_of_birth, address) VALUES (1, 205, 'Noah', 'Taylor', '412000005', 'noah.taylor5@email.com', 'Male', '1993-01-10', '17 Creekside, Greenway');
INSERT INTO customers (shop_id, customer_id, first_name, last_name, mobile, email, gender, date_of_birth, address) VALUES (1, 206, 'Ava', 'Martin', '412000006', 'ava.martin6@email.com', 'Female', '1997-09-25', '39 Hilltop Rd, Greenway');
INSERT INTO customers (shop_id, customer_id, first_name, last_name, mobile, email, gender, date_of_birth, address) VALUES (1, 207, 'Ethan', 'Thompson', '412000007', 'ethan.thompson7@email.com', 'Male', '1989-04-08', '55 Valley St, Greenway');
INSERT INTO customers (shop_id, customer_id, first_name, last_name, mobile, email, gender, date_of_birth, address) VALUES (1, 208, 'Mia', 'White', '412000008', 'mia.white8@email.com', 'Female', '1996-02-14', '23 Willow Ct, Greenway');
INSERT INTO customers (shop_id, customer_id, first_name, last_name, mobile, email, gender, date_of_birth, address) VALUES (1, 209, 'Lucas', 'Harris', '412000009', 'lucas.harris9@email.com', 'Male', '1991-09-30', '11 Maple St, Greenway');
INSERT INTO customers (shop_id, customer_id, first_name, last_name, mobile, email, gender, date_of_birth, address) VALUES (1, 210, 'Sophia', 'Clark', '412000010', 'sophia.clark10@email.com', 'Female', '1994-05-22', '7 Park Rd, Greenway');
INSERT INTO customers (shop_id, customer_id, first_name, last_name, mobile, email, gender, date_of_birth, address) VALUES (2, 211, 'James', 'Hall', '412000011', 'james.hall11@email.com', 'Male', '1987-10-18', '14 Weston Rd, Weston');
INSERT INTO customers (shop_id, customer_id, first_name, last_name, mobile, email, gender, date_of_birth, address) VALUES (2, 212, 'Amelia', 'Lewis', '412000012', 'amelia.lewis12@email.com', 'Female', '1999-02-27', '66 Weston Blvd, Weston');
INSERT INTO customers (shop_id, customer_id, first_name, last_name, mobile, email, gender, date_of_birth, address) VALUES (2, 213, 'Henry', 'Young', '412000013', 'henry.young13@email.com', 'Male', '1985-07-12', '21 River St, Weston');
INSERT INTO customers (shop_id, customer_id, first_name, last_name, mobile, email, gender, date_of_birth, address) VALUES (2, 214, 'Charlotte', 'King', '412000014', 'charlotte.king14@email.com', 'Female', '1998-08-30', '18 Garden Ave, Weston');
INSERT INTO customers (shop_id, customer_id, first_name, last_name, mobile, email, gender, date_of_birth, address) VALUES (2, 215, 'William', 'Scott', '412000015', 'william.scott15@email.com', 'Male', '1990-04-03', '99 Lakeview Dr, Weston');
INSERT INTO customers (shop_id, customer_id, first_name, last_name, mobile, email, gender, date_of_birth, address) VALUES (2, 216, 'Isabella', 'Green', '412000016', 'isabella.green16@email.com', 'Female', '1996-01-19', '45 Maple St, Weston');
INSERT INTO customers (shop_id, customer_id, first_name, last_name, mobile, email, gender, date_of_birth, address) VALUES (2, 217, 'Daniel', 'Adams', '412000017', 'daniel.adams17@email.com', 'Male', '1992-11-15', '34 Parkview Rd, Weston');
INSERT INTO customers (shop_id, customer_id, first_name, last_name, mobile, email, gender, date_of_birth, address) VALUES (2, 218, 'Grace', 'Baker', '412000018', 'grace.baker18@email.com', 'Female', '1993-06-08', '78 Weston Heights, Weston');
INSERT INTO customers (shop_id, customer_id, first_name, last_name, mobile, email, gender, date_of_birth, address) VALUES (2, 219, 'Matthew', 'Carter', '412000019', 'matthew.carter19@email.com', 'Male', '1989-09-20', '51 Pine Rd, Weston');
INSERT INTO customers (shop_id, customer_id, first_name, last_name, mobile, email, gender, date_of_birth, address) VALUES (2, 220, 'Chloe', 'Evans', '412000020', 'chloe.evans20@email.com', 'Female', '1997-12-14', '26 Riverway, Weston');
INSERT INTO customers (shop_id, customer_id, first_name, last_name, mobile, email, gender, date_of_birth, address) VALUES (3, 221, 'Samuel', 'Foster', '412000021', 'samuel.foster21@email.com', 'Male', '1991-01-05', '12 Gungahlin Rd, Gungahlin');
INSERT INTO customers (shop_id, customer_id, first_name, last_name, mobile, email, gender, date_of_birth, address) VALUES (3, 222, 'Lily', 'Gray', '412000022', 'lily.gray22@email.com', 'Female', '1994-03-19', '48 Hilltop Dr, Gungahlin');
INSERT INTO customers (shop_id, customer_id, first_name, last_name, mobile, email, gender, date_of_birth, address) VALUES (3, 223, 'Alexander', 'Hughes', '412000023', 'alex.hughes23@email.com', 'Male', '1990-06-25', '31 Creekside, Gungahlin');
INSERT INTO customers (shop_id, customer_id, first_name, last_name, mobile, email, gender, date_of_birth, address) VALUES (3, 224, 'Zoe', 'Jenkins', '412000024', 'zoe.jenkins24@email.com', 'Female', '1995-08-11', '15 Park Rd, Gungahlin');
INSERT INTO customers (shop_id, customer_id, first_name, last_name, mobile, email, gender, date_of_birth, address) VALUES (3, 225, 'Benjamin', 'Kelly', '412000025', 'ben.kelly25@email.com', 'Male', '1988-12-03', '75 Valley St, Gungahlin');
INSERT INTO customers (shop_id, customer_id, first_name, last_name, mobile, email, gender, date_of_birth, address) VALUES (3, 226, 'Ella', 'Lopez', '412000026', 'ella.lopez26@email.com', 'Female', '1993-07-29', '54 Garden Rd, Gungahlin');
INSERT INTO customers (shop_id, customer_id, first_name, last_name, mobile, email, gender, date_of_birth, address) VALUES (3, 227, 'Michael', 'Morris', '412000027', 'michael.morris27@email.com', 'Male', '1996-02-09', '42 Willow St, Gungahlin');
INSERT INTO customers (shop_id, customer_id, first_name, last_name, mobile, email, gender, date_of_birth, address) VALUES (3, 228, 'Harper', 'Nelson', '412000028', 'harper.nelson28@email.com', 'Female', '1992-10-23', '88 Lake St, Gungahlin');
INSERT INTO customers (shop_id, customer_id, first_name, last_name, mobile, email, gender, date_of_birth, address) VALUES (3, 229, 'Jack', 'Ortiz', '412000029', 'jack.ortiz29@email.com', 'Male', '1998-04-16', '29 Mountain Rd, Gungahlin');
INSERT INTO customers (shop_id, customer_id, first_name, last_name, mobile, email, gender, date_of_birth, address) VALUES (3, 230, 'Layla', 'Perez', '412000030', 'layla.perez30@email.com', 'Female', '1991-09-07', '60 Creek Rd, Gungahlin');
INSERT INTO customers (shop_id, customer_id, first_name, last_name, mobile, email, gender, date_of_birth, address) VALUES (3, 231, 'David', 'Quinn', '412000031', 'david.quinn31@email.com', 'Male', '1987-11-11', '72 Hillcrest, Gungahlin');
INSERT INTO customers (shop_id, customer_id, first_name, last_name, mobile, email, gender, date_of_birth, address) VALUES (3, 232, 'Aria', 'Roberts', '412000032', 'aria.roberts32@email.com', 'Female', '1999-05-05', '37 Meadow St, Gungahlin');
INSERT INTO customers (shop_id, customer_id, first_name, last_name, mobile, email, gender, date_of_birth, address) VALUES (3, 233, 'Thomas', 'Stewart', '412000033', 'thomas.stewart33@email.com', 'Male', '1995-02-28', '64 Park Ave, Gungahlin');
INSERT INTO customers (shop_id, customer_id, first_name, last_name, mobile, email, gender, date_of_birth, address) VALUES (3, 234, 'Sofia', 'Turner', '412000034', 'sofia.turner34@email.com', 'Female', '1992-06-14', '19 Lakeview Rd, Gungahlin');
INSERT INTO customers (shop_id, customer_id, first_name, last_name, mobile, email, gender, date_of_birth, address) VALUES (3, 235, 'Oliver', 'Walker', '412000035', 'oliver.walker35@email.com', 'Male', '1990-08-19', '81 Main St, Gungahlin');

select * from customers;

INSERT INTO orders (shop_id, customer_id, order_id, order_datetime, payment_id, order_value) VALUES (1, 101, 1001, '2025-08-01 09:15:23', 1, 29.9);
INSERT INTO orders (shop_id, customer_id, order_id, order_datetime, payment_id, order_value) VALUES (1, 102, 1002, '2025-08-01 09:45:10', 2, 58.4);
INSERT INTO orders (shop_id, customer_id, order_id, order_datetime, payment_id, order_value) VALUES (2, 103, 1003, '2025-08-01 10:05:42', 3, 14.95);
INSERT INTO orders (shop_id, customer_id, order_id, order_datetime, payment_id, order_value) VALUES (3, 104, 1004, '2025-08-01 10:18:11', 1, 43.8);
INSERT INTO orders (shop_id, customer_id, order_id, order_datetime, payment_id, order_value) VALUES (1, 105, 1005, '2025-08-01 10:27:55', 4, 72.5);
INSERT INTO orders (shop_id, customer_id, order_id, order_datetime, payment_id, order_value) VALUES (2, 106, 1006, '2025-08-01 10:40:12', 1, 19.95);
INSERT INTO orders (shop_id, customer_id, order_id, order_datetime, payment_id, order_value) VALUES (3, 107, 1007, '2025-08-01 11:02:34', 2, 25.9);
INSERT INTO orders (shop_id, customer_id, order_id, order_datetime, payment_id, order_value) VALUES (1, 108, 1008, '2025-08-01 11:18:50', 3, 33.4);
INSERT INTO orders (shop_id, customer_id, order_id, order_datetime, payment_id, order_value) VALUES (1, 109, 1009, '2025-08-01 11:35:22', 1, 49.95);
INSERT INTO orders (shop_id, customer_id, order_id, order_datetime, payment_id, order_value) VALUES (2, 110, 1010, '2025-08-01 11:50:44', 4, 65.8);
INSERT INTO orders (shop_id, customer_id, order_id, order_datetime, payment_id, order_value) VALUES (3, 111, 1011, '2025-08-01 12:05:17', 2, 23.95);
INSERT INTO orders (shop_id, customer_id, order_id, order_datetime, payment_id, order_value) VALUES (1, 112, 1012, '2025-08-01 12:22:30', 1, 18.95);
INSERT INTO orders (shop_id, customer_id, order_id, order_datetime, payment_id, order_value) VALUES (2, 113, 1013, '2025-08-01 12:41:05', 3, 37.9);
INSERT INTO orders (shop_id, customer_id, order_id, order_datetime, payment_id, order_value) VALUES (3, 114, 1014, '2025-08-01 12:59:48', 2, 54.2);
INSERT INTO orders (shop_id, customer_id, order_id, order_datetime, payment_id, order_value) VALUES (1, 115, 1015, '2025-08-01 13:10:09', 1, 21.95);
INSERT INTO orders (shop_id, customer_id, order_id, order_datetime, payment_id, order_value) VALUES (2, 116, 1016, '2025-08-01 13:24:33', 4, 46.95);
INSERT INTO orders (shop_id, customer_id, order_id, order_datetime, payment_id, order_value) VALUES (3, 117, 1017, '2025-08-01 13:39:50', 2, 28.9);
INSERT INTO orders (shop_id, customer_id, order_id, order_datetime, payment_id, order_value) VALUES (1, 118, 1018, '2025-08-01 14:01:12', 1, 32.95);
INSERT INTO orders (shop_id, customer_id, order_id, order_datetime, payment_id, order_value) VALUES (1, 119, 1019, '2025-08-01 14:17:44', 3, 59.95);
INSERT INTO orders (shop_id, customer_id, order_id, order_datetime, payment_id, order_value) VALUES (2, 120, 1020, '2025-08-01 14:36:29', 2, 16.95);
INSERT INTO orders (shop_id, customer_id, order_id, order_datetime, payment_id, order_value) VALUES (3, 121, 1021, '2025-08-01 14:52:01', 1, 74.95);
INSERT INTO orders (shop_id, customer_id, order_id, order_datetime, payment_id, order_value) VALUES (1, 122, 1022, '2025-08-01 15:09:45', 4, 29.5);
INSERT INTO orders (shop_id, customer_id, order_id, order_datetime, payment_id, order_value) VALUES (2, 123, 1023, '2025-08-01 15:25:19', 2, 41.95);
INSERT INTO orders (shop_id, customer_id, order_id, order_datetime, payment_id, order_value) VALUES (3, 124, 1024, '2025-08-01 15:43:56', 3, 36.9);
INSERT INTO orders (shop_id, customer_id, order_id, order_datetime, payment_id, order_value) VALUES (1, 125, 1025, '2025-08-01 16:02:40', 1, 23.9);
INSERT INTO orders (shop_id, customer_id, order_id, order_datetime, payment_id, order_value) VALUES (2, 126, 1026, '2025-08-01 16:20:55', 2, 44.95);
INSERT INTO orders (shop_id, customer_id, order_id, order_datetime, payment_id, order_value) VALUES (3, 127, 1027, '2025-08-01 16:39:27', 3, 58.95);
INSERT INTO orders (shop_id, customer_id, order_id, order_datetime, payment_id, order_value) VALUES (1, 128, 1028, '2025-08-01 16:55:31', 1, 27.5);
INSERT INTO orders (shop_id, customer_id, order_id, order_datetime, payment_id, order_value) VALUES (2, 129, 1029, '2025-08-01 17:10:45', 4, 33.95);
INSERT INTO orders (shop_id, customer_id, order_id, order_datetime, payment_id, order_value) VALUES (3, 130, 1030, '2025-08-01 17:29:10', 2, 49.9);

select * from orders;


INSERT INTO order_items (menu_item_id, order_id, quantity, unit_price, line_total) VALUES (2, 1001, 2, 14.95, 29.9);
INSERT INTO order_items (menu_item_id, order_id, quantity, unit_price, line_total) VALUES (5, 1001, 1, 28.5, 28.5);
INSERT INTO order_items (menu_item_id, order_id, quantity, unit_price, line_total) VALUES (8, 1002, 3, 19.5, 58.5);
INSERT INTO order_items (menu_item_id, order_id, quantity, unit_price, line_total) VALUES (11, 1003, 1, 14.95, 14.95);
INSERT INTO order_items (menu_item_id, order_id, quantity, unit_price, line_total) VALUES (3, 1004, 2, 21.9, 43.8);
INSERT INTO order_items (menu_item_id, order_id, quantity, unit_price, line_total) VALUES (9, 1005, 2, 36.25, 72.5);
INSERT INTO order_items (menu_item_id, order_id, quantity, unit_price, line_total) VALUES (7, 1006, 1, 19.95, 19.95);
INSERT INTO order_items (menu_item_id, order_id, quantity, unit_price, line_total) VALUES (12, 1007, 2, 12.95, 25.9);
INSERT INTO order_items (menu_item_id, order_id, quantity, unit_price, line_total) VALUES (4, 1008, 1, 33.4, 33.4);
INSERT INTO order_items (menu_item_id, order_id, quantity, unit_price, line_total) VALUES (10, 1009, 2, 24.95, 49.9);
INSERT INTO order_items (menu_item_id, order_id, quantity, unit_price, line_total) VALUES (6, 1010, 4, 16.45, 65.8);
INSERT INTO order_items (menu_item_id, order_id, quantity, unit_price, line_total) VALUES (1, 1011, 1, 23.95, 23.95);
INSERT INTO order_items (menu_item_id, order_id, quantity, unit_price, line_total) VALUES (14, 1012, 1, 18.95, 18.95);
INSERT INTO order_items (menu_item_id, order_id, quantity, unit_price, line_total) VALUES (15, 1013, 2, 18.95, 37.9);
INSERT INTO order_items (menu_item_id, order_id, quantity, unit_price, line_total) VALUES (16, 1014, 2, 27.1, 54.2);
INSERT INTO order_items (menu_item_id, order_id, quantity, unit_price, line_total) VALUES (18, 1015, 1, 21.95, 21.95);
INSERT INTO order_items (menu_item_id, order_id, quantity, unit_price, line_total) VALUES (19, 1016, 3, 15.65, 46.95);
INSERT INTO order_items (menu_item_id, order_id, quantity, unit_price, line_total) VALUES (20, 1017, 2, 14.45, 28.9);
INSERT INTO order_items (menu_item_id, order_id, quantity, unit_price, line_total) VALUES (21, 1018, 1, 32.95, 32.95);
INSERT INTO order_items (menu_item_id, order_id, quantity, unit_price, line_total) VALUES (22, 1019, 1, 29.95, 29.95);
INSERT INTO order_items (menu_item_id, order_id, quantity, unit_price, line_total) VALUES (23, 1019, 2, 15, 30);
INSERT INTO order_items (menu_item_id, order_id, quantity, unit_price, line_total) VALUES (24, 1020, 1, 16.95, 16.95);
INSERT INTO order_items (menu_item_id, order_id, quantity, unit_price, line_total) VALUES (25, 1021, 5, 14.99, 74.95);
INSERT INTO order_items (menu_item_id, order_id, quantity, unit_price, line_total) VALUES (26, 1022, 2, 14.75, 29.5);
INSERT INTO order_items (menu_item_id, order_id, quantity, unit_price, line_total) VALUES (27, 1023, 1, 41.95, 41.95);
INSERT INTO order_items (menu_item_id, order_id, quantity, unit_price, line_total) VALUES (28, 1024, 3, 12.3, 36.9);
INSERT INTO order_items (menu_item_id, order_id, quantity, unit_price, line_total) VALUES (29, 1025, 2, 11.95, 23.9);
INSERT INTO order_items (menu_item_id, order_id, quantity, unit_price, line_total) VALUES (30, 1026, 1, 44.95, 44.95);
INSERT INTO order_items (menu_item_id, order_id, quantity, unit_price, line_total) VALUES (31, 1027, 2, 29.48, 58.95);
INSERT INTO order_items (menu_item_id, order_id, quantity, unit_price, line_total) VALUES (32, 1028, 1, 27.5, 27.5);

select * from customers;

INSERT INTO orders (shop_id, customer_id, order_id, order_datetime, payment_id, order_value) VALUES (1, 201, 1001, '2025-08-01 09:15:23', 1, 29.9);
INSERT INTO orders (shop_id, customer_id, order_id, order_datetime, payment_id, order_value) VALUES (1, 202, 1002, '2025-08-01 09:45:10', 2, 58.4);
INSERT INTO orders (shop_id, customer_id, order_id, order_datetime, payment_id, order_value) VALUES (2, 203, 1003, '2025-08-01 10:05:42', 3, 14.95);
INSERT INTO orders (shop_id, customer_id, order_id, order_datetime, payment_id, order_value) VALUES (3, 204, 1004, '2025-08-01 10:18:11', 1, 43.8);
INSERT INTO orders (shop_id, customer_id, order_id, order_datetime, payment_id, order_value) VALUES (1, 205, 1005, '2025-08-01 10:27:55', 4, 72.5);
INSERT INTO orders (shop_id, customer_id, order_id, order_datetime, payment_id, order_value) VALUES (2, 206, 1006, '2025-08-01 10:40:12', 1, 19.95);
INSERT INTO orders (shop_id, customer_id, order_id, order_datetime, payment_id, order_value) VALUES (3, 207, 1007, '2025-08-01 11:02:34', 2, 25.9);
INSERT INTO orders (shop_id, customer_id, order_id, order_datetime, payment_id, order_value) VALUES (1, 208, 1008, '2025-08-01 11:18:50', 3, 33.4);
INSERT INTO orders (shop_id, customer_id, order_id, order_datetime, payment_id, order_value) VALUES (1, 209, 1009, '2025-08-01 11:35:22', 1, 49.95);
INSERT INTO orders (shop_id, customer_id, order_id, order_datetime, payment_id, order_value) VALUES (2, 210, 1010, '2025-08-01 11:50:44', 4, 65.8);
INSERT INTO orders (shop_id, customer_id, order_id, order_datetime, payment_id, order_value) VALUES (3, 211, 1011, '2025-08-01 12:05:17', 2, 23.95);
INSERT INTO orders (shop_id, customer_id, order_id, order_datetime, payment_id, order_value) VALUES (1, 212, 1012, '2025-08-01 12:22:30', 1, 18.95);
INSERT INTO orders (shop_id, customer_id, order_id, order_datetime, payment_id, order_value) VALUES (2, 213, 1013, '2025-08-01 12:41:05', 3, 37.9);
INSERT INTO orders (shop_id, customer_id, order_id, order_datetime, payment_id, order_value) VALUES (3, 214, 1014, '2025-08-01 12:59:48', 2, 54.2);
INSERT INTO orders (shop_id, customer_id, order_id, order_datetime, payment_id, order_value) VALUES (1, 215, 1015, '2025-08-01 13:10:09', 1, 21.95);
INSERT INTO orders (shop_id, customer_id, order_id, order_datetime, payment_id, order_value) VALUES (2, 216, 1016, '2025-08-01 13:24:33', 4, 46.95);
INSERT INTO orders (shop_id, customer_id, order_id, order_datetime, payment_id, order_value) VALUES (3, 217, 1017, '2025-08-01 13:39:50', 2, 28.9);
INSERT INTO orders (shop_id, customer_id, order_id, order_datetime, payment_id, order_value) VALUES (1, 218, 1018, '2025-08-01 14:01:12', 1, 32.95);
INSERT INTO orders (shop_id, customer_id, order_id, order_datetime, payment_id, order_value) VALUES (1, 219, 1019, '2025-08-01 14:17:44', 3, 59.95);
INSERT INTO orders (shop_id, customer_id, order_id, order_datetime, payment_id, order_value) VALUES (2, 220, 1020, '2025-08-01 14:36:29', 2, 16.95);
INSERT INTO orders (shop_id, customer_id, order_id, order_datetime, payment_id, order_value) VALUES (3, 221, 1021, '2025-08-01 14:52:01', 1, 74.95);
INSERT INTO orders (shop_id, customer_id, order_id, order_datetime, payment_id, order_value) VALUES (1, 222, 1022, '2025-08-01 15:09:45', 4, 29.5);
INSERT INTO orders (shop_id, customer_id, order_id, order_datetime, payment_id, order_value) VALUES (2, 223, 1023, '2025-08-01 15:25:19', 2, 41.95);
INSERT INTO orders (shop_id, customer_id, order_id, order_datetime, payment_id, order_value) VALUES (3, 224, 1024, '2025-08-01 15:43:56', 3, 36.9);
INSERT INTO orders (shop_id, customer_id, order_id, order_datetime, payment_id, order_value) VALUES (1, 225, 1025, '2025-08-01 16:02:40', 1, 23.9);
INSERT INTO orders (shop_id, customer_id, order_id, order_datetime, payment_id, order_value) VALUES (2, 226, 1026, '2025-08-01 16:20:55', 2, 44.95);
INSERT INTO orders (shop_id, customer_id, order_id, order_datetime, payment_id, order_value) VALUES (3, 227, 1027, '2025-08-01 16:39:27', 3, 58.95);
INSERT INTO orders (shop_id, customer_id, order_id, order_datetime, payment_id, order_value) VALUES (1, 228, 1028, '2025-08-01 16:55:31', 1, 27.5);
INSERT INTO orders (shop_id, customer_id, order_id, order_datetime, payment_id, order_value) VALUES (2, 229, 1029, '2025-08-01 17:10:45', 4, 33.95);
INSERT INTO orders (shop_id, customer_id, order_id, order_datetime, payment_id, order_value) VALUES (3, 230, 1030, '2025-08-01 17:29:10', 2, 49.9);

select * from orders;


select * from order_items;


INSERT INTO menu_items (category_id,menu_item_id, menu_item_name, price) VALUES (12, 32, 'New Drink', 5.99);

select * from menu_items;

INSERT INTO order_items (order_item_id, menu_item_id, order_id, quantity, unit_price, line_total) VALUES (1, 2, 1001, 2, 14.95, 29.9);
INSERT INTO order_items (order_item_id, menu_item_id, order_id, quantity, unit_price, line_total) VALUES (2, 5, 1001, 1, 28.5, 28.5);
INSERT INTO order_items (order_item_id, menu_item_id, order_id, quantity, unit_price, line_total) VALUES (3, 8, 1002, 3, 19.5, 58.5);
INSERT INTO order_items (order_item_id, menu_item_id, order_id, quantity, unit_price, line_total) VALUES (4, 11, 1003, 1, 14.95, 14.95);
INSERT INTO order_items (order_item_id, menu_item_id, order_id, quantity, unit_price, line_total) VALUES (5, 3, 1004, 2, 21.9, 43.8);
INSERT INTO order_items (order_item_id, menu_item_id, order_id, quantity, unit_price, line_total) VALUES (6, 9, 1005, 2, 36.25, 72.5);
INSERT INTO order_items (order_item_id, menu_item_id, order_id, quantity, unit_price, line_total) VALUES (7, 7, 1006, 1, 19.95, 19.95);
INSERT INTO order_items (order_item_id, menu_item_id, order_id, quantity, unit_price, line_total) VALUES (8, 12, 1007, 2, 12.95, 25.9);
INSERT INTO order_items (order_item_id, menu_item_id, order_id, quantity, unit_price, line_total) VALUES (9, 4, 1008, 1, 33.4, 33.4);
INSERT INTO order_items (order_item_id, menu_item_id, order_id, quantity, unit_price, line_total) VALUES (10, 10, 1009, 2, 24.95, 49.9);
INSERT INTO order_items (order_item_id, menu_item_id, order_id, quantity, unit_price, line_total) VALUES (11, 6, 1010, 4, 16.45, 65.8);
INSERT INTO order_items (order_item_id, menu_item_id, order_id, quantity, unit_price, line_total) VALUES (12, 1, 1011, 1, 23.95, 23.95);
INSERT INTO order_items (order_item_id, menu_item_id, order_id, quantity, unit_price, line_total) VALUES (13, 14, 1012, 1, 18.95, 18.95);
INSERT INTO order_items (order_item_id, menu_item_id, order_id, quantity, unit_price, line_total) VALUES (14, 15, 1013, 2, 18.95, 37.9);
INSERT INTO order_items (order_item_id, menu_item_id, order_id, quantity, unit_price, line_total) VALUES (15, 16, 1014, 2, 27.1, 54.2);
INSERT INTO order_items (order_item_id, menu_item_id, order_id, quantity, unit_price, line_total) VALUES (16, 18, 1015, 1, 21.95, 21.95);
INSERT INTO order_items (order_item_id, menu_item_id, order_id, quantity, unit_price, line_total) VALUES (17, 19, 1016, 3, 15.65, 46.95);
INSERT INTO order_items (order_item_id, menu_item_id, order_id, quantity, unit_price, line_total) VALUES (18, 20, 1017, 2, 14.45, 28.9);
INSERT INTO order_items (order_item_id, menu_item_id, order_id, quantity, unit_price, line_total) VALUES (19, 21, 1018, 1, 32.95, 32.95);
INSERT INTO order_items (order_item_id, menu_item_id, order_id, quantity, unit_price, line_total) VALUES (20, 22, 1019, 1, 29.95, 29.95);
INSERT INTO order_items (order_item_id, menu_item_id, order_id, quantity, unit_price, line_total) VALUES (21, 23, 1019, 2, 15, 30);
INSERT INTO order_items (order_item_id, menu_item_id, order_id, quantity, unit_price, line_total) VALUES (22, 24, 1020, 1, 16.95, 16.95);
INSERT INTO order_items (order_item_id, menu_item_id, order_id, quantity, unit_price, line_total) VALUES (23, 25, 1021, 5, 14.99, 74.95);
INSERT INTO order_items (order_item_id, menu_item_id, order_id, quantity, unit_price, line_total) VALUES (24, 26, 1022, 2, 14.75, 29.5);
INSERT INTO order_items (order_item_id, menu_item_id, order_id, quantity, unit_price, line_total) VALUES (25, 27, 1023, 1, 41.95, 41.95);
INSERT INTO order_items (order_item_id, menu_item_id, order_id, quantity, unit_price, line_total) VALUES (26, 28, 1024, 3, 12.3, 36.9);
INSERT INTO order_items (order_item_id, menu_item_id, order_id, quantity, unit_price, line_total) VALUES (27, 29, 1025, 2, 11.95, 23.9);
INSERT INTO order_items (order_item_id, menu_item_id, order_id, quantity, unit_price, line_total) VALUES (28, 30, 1026, 1, 44.95, 44.95);
INSERT INTO order_items (order_item_id, menu_item_id, order_id, quantity, unit_price, line_total) VALUES (29, 31, 1027, 2, 29.48, 58.96);
INSERT INTO order_items (order_item_id, menu_item_id, order_id, quantity, unit_price, line_total) VALUES (30, 32, 1028, 1, 27.5, 27.5);

--check all tables 

select * from order_items;
select * from orders;
select * from menu_items;
select * from staff;
select * from customers;
select * from categories;
select * from shops;
select * from delivery_methods;
select * from payment_methods;
