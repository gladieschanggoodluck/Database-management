CREATE TABLE IF NOT EXISTS `Manufacturer` (

  `name` varchar(200) NOT NULL,
  `maximum_discount` real NOT NULL,

  PRIMARY KEY (`name`)
) DEFAULT CHARSET=utf8;
INSERT INTO `Manufacturer` (`name`, `maximum_discount`) VALUES
    ("Manfufac" , 0.3),
    ("manufacturerOne", 0.1),
    ("ManuTwo", 0.2),
    ("TestManu", 0.15);


CREATE TABLE IF NOT EXISTS `Product` (
  `pid` int(6) unsigned NOT NULL,
  `name` varchar(200) NOT NULL,
  `retail_price` real NOT NULL,
  `manufacturer` varchar(200) NOT NULL,
  PRIMARY KEY (`PID`)
) DEFAULT CHARSET=utf8;
INSERT INTO `Product` (`pid`, `name`, `retail_price`, `manufacturer`) VALUES
    ("1", "pc_a1", "100", "Manfufac"),
    ("2", "pc_a2", "140", "manufacturerOne"),
    ("3", "pc_a3", "160", "ManuTwo"),
    ("4", "pc_o1", "200", "TestManu"),
    ("5", "pc_o2", "250", "TestManu"),
    ("6", "pc_o3", "300", "TestManu"),
    ("7", "pc_b1", "180", "TestManu"),
    ("8", "pc_b2", "170", "TestManu"),
    ("9", "pc_b3", "190", "TestManu");
    
    

CREATE TABLE IF NOT EXISTS `ProductToCategory` (
  `pid` int(6) unsigned NOT NULL,
  `category` varchar(200) NOT NULL,
  PRIMARY KEY (`pid`, `category`)
) DEFAULT CHARSET=utf8;   

INSERT INTO `ProductToCategory` (`pid`, `category`) VALUES
    (1, 'Consumable'),
    (1, 'Office'),
    (3, 'Office'),
    (2, 'Tool');
    
    
SELECT M.name, count(P.name), AVG(P.retail_price), max(P.retail_price), min(P.retail_price) 
FROM `Manufacturer` AS M 
INNER JOIN `Product` AS P on M.name = P.manufacturer 
GROUP BY M.name
ORDER BY AVG(P.retail_price) DESC LIMIT 100;

SELECT name, maximum_discount FROM `Manufacturer`; 

SELECT P.pid, P.name, group_concat(PT.category), P.retail_price 
FROM `Product`  AS P 
INNER JOIN `ProductToCategory` AS PT ON P.pid = PT.pid 
GROUP BY PT.pid 
ORDER BY P.retail_price DESC;
