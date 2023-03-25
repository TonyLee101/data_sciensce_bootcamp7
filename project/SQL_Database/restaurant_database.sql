-- restaurant database

-- 5 tables
--write 3-5 queries
-- 1x WITH
-- 1x SUBQUERY
-- 1x Aggregate Function

.open restaurant.db
.mode column
.mode box

DROP TABLE menus;
DROP TABLE transaction_report;
DROP TABLE customers;
DROP TABLE crews;
DROP TABLE promotion;
  
-- Table 1 --
CREATE TABLE transaction_report (
  ID int,
  trans_date date,
  cust_ID int,
  crew_ID int,
  menu_ID int,
  amount real,
  PRIMARY KEY (ID),
  FOREIGN KEY (cust_ID) REFERENCES customers(cust_ID),
  FOREIGN KEY (crew_ID) REFERENCES crews(crew_ID),
  FOREIGN KEY (menu_ID) REFERENCES menus(menu_id)
);
-- Table 2 --
CREATE TABLE customers (
  cust_ID int,
  name text,
  gender text,
  age int,
  email text,
  status text,
  PRIMARY KEY (cust_ID)
);
-- Table 3 --
CREATE TABLE crews (
  crew_ID int,
  name text,
  gender text,
  PRIMARY KEY (crew_ID)
);

-- Table 4 --
CREATE TABLE menus (
  menu_id INT,
  name text,
  type text,
  price real,
  PRIMARY KEY (menu_id)
);

--Table 5 --
CREATE TABLE promotion (
  status text,
  discount text,
  PRIMARY KEY (status)
);

INSERT INTO customers values
  (1,'Tony','M',29,'tony@mail.com','member'),
  (2,'Fon','F',34,'fonza@mail.com','non-member'),
  (3,'Bank','M',28,'bbank66@mail.com','member'),
  (4,'Andy','M,',27,'andy@mail.com','non-member'),
  (5,'Palm','F',18,'palmmy@mail.com','non-member');

INSERT INTO crews values
  (1,'Ritta','M'),
  (2,'Noo','F');

INSERT INTO menus values
  (1,'Ham & Cheese','food',80),
  (2,'HOTDOG','food',100),
  (3,'Bacon','food',150),
  (4,'Egg & Cheese','food',100),
  (5,'Chicken Burger','food',150),
  (6,'Salad','food',180),
  (7,'Hotcake','food',120),
  (8,'Waffle','food',80),
  (9,'Beef Streak','food',300),
  (10,'Salmon','food',260),
  (11,'Coffee Late','coffee',35),
  (12,'Coffee Americano','coffee',35),
  (13,'Coffee Cappuccino','coffee',35),
  (14,'Coffee Single Shot','coffee',15),
  (15,'Coffee Cloud Mocchiato','coffee',35),
  (16,'Dolce Late','coffee',45),
  (17,'Water','drink',10),
  (18,'Soda','drink',10);

INSERT INTO transaction_report values
  (1,"2023-02-12",1,2,10,1),
  (2,"2023-02-01",1,2,2,1),
  (3,"2023-02-02",3,1,15,1),
  (4,"2023-02-13",2,1,12,1),
  (5,"2023-02-02",2,2,13,1),
  (6,"2023-01-11",1,1,10,1),
  (7,"2023-01-30",3,1,15,1),
  (8,"2023-01-12",3,2,11,1),
  (9,"2023-02-14",4,1,7,1),
  (10,"2023-02-05",5,2,5,1),
  (11,"2023-02-07",4,2,14,1),
  (12,"2023-02-09",5,1,9,1),
  (13,"2023-02-10",1,1,16,1),
  (14,"2023-02-12",4,1,15,1),
  (15,"2023-02-12",1,1,11,1),
  (16,"2023-02-14",5,2,12,1),
  (17,"2023-02-14",4,1,13,1),
  (18,"2023-02-25",3,1,16,1),
  (19,"2023-02-25",2,1,16,1),
  (20,"2023-02-26",1,2,16,1);

INSERT INTO promotion values
  ('member','10%'),
  ('non-member','0');

-- Data Visualize --
.print '-- Restaurant Transaction --'
SELECT 
   t.trans_date,
   c.name as customer_name,
   c.status,
   m.name list_menu,
   CASE WHEN c.status = 'member' THEN 
         t.amount * m.price * (1 - CAST(p.discount AS REAL)/100)
   ELSE t.amount * m.price  
   END Total,
   p.discount AS Discount
    
 FROM transaction_report as t
 join customers as c on c.cust_ID = t.cust_ID
 join crews on crews.crew_ID = t.crew_ID
 join menus as m on m.menu_ID = t.menu_ID
 join (SELECT status, discount FROM promotion
 ) as p on c.status = p.status
  ORDER BY 1;

.print '-- TOP5 Coffee --'
  
WITH top5_coffee AS (
  SELECT * FROM menus
  WHERE type = 'coffee'
)
SELECT
 top5.name,
  COUNT(t.amount) Count
FROM top5_coffee as top5
JOIN transaction_report as t
ON t.menu_ID = top5.menu_ID
GROUP BY 1
ORDER BY 2 desc
LIMIT 5
;
