CREATE TABLE IF NOT EXISTS `Membership` (
  `member_id` int(6) unsigned NOT NULL,
  `signup_date` date NOT NULL,
  `store_id` int(6) unsigned NOT NULL,
  PRIMARY KEY (`member_id`)
) DEFAULT CHARSET=utf8;
INSERT INTO `Membership` (`member_id`, `signup_date`, `store_id`) VALUES
    (1001, "2020-03-03 00:00:00", 100),
    (1002, "2020-03-03 00:00:00", 101),
    (1003, "2020-01-02 00:00:00", 101),
    (1004, "2020-05-25 00:00:00", 102),
    (1005, "2020-05-25 00:00:00", 102);

CREATE TABLE IF NOT EXISTS `GiantHornet` (
  `member_id` int(6) unsigned NOT NULL,
  PRIMARY KEY (`member_id`)
) DEFAULT CHARSET=utf8;
INSERT INTO `GiantHornet` (`member_id`) VALUES
    (1001);
    
CREATE TABLE IF NOT EXISTS `YellowJacket` (
  `member_id` int(6) unsigned NOT NULL,
  PRIMARY KEY (`member_id`)
) DEFAULT CHARSET=utf8;
INSERT INTO `YellowJacket` (`member_id`) VALUES
    (1002),    
    (1003),   
    (1004),
    (1005);


CREATE TABLE IF NOT EXISTS `Store` (
  `store_id` int(6) unsigned NOT NULL,
  `address` varchar(200) NOT NULL,
  `phone` varchar(200) NOT NULL,
  `city` varchar(200) NOT NULL,
  `state` varchar(200) NOT NULL,
  PRIMARY KEY (`store_id`)
) DEFAULT CHARSET=utf8;
INSERT INTO `Store` (`store_id`, `address`, `phone`, `city`, `state`) VALUES
    ("100", "pc_a1", "100", "apple", "apple"),
    ("101", "pc_a2", "140", "apple", "apple"),
    ("102", "pc_a3", "160", "apple", "apple"),
    ("103", "pc_o1", "200", "orange", "apple"),
    ("104", "pc_o2", "250", "orange", "apple"),
    ("105", "pc_o3", "300", "orange", "apple"),
    ("106", "pc_b1", "180", "banana", "apple"),
    ("107", "pc_b2", "170", "banana", "apple"),
    ("108", "pc_b3", "190", "banana", "apple");


SELECT COUNT(M.member_id), EXTRACT(YEAR FROM M.signup_date) AS YEAR
FROM `Membership` AS M
GROUP BY YEAR
ORDER BY YEAR ASC;




SELECT COUNT(M.member_id), S.city FROM `Store` AS S
INNER JOIN `Membership` AS M
ON S.store_id = M.store_id
GROUP BY S.city
ORDER BY COUNT(M.member_id) DESC LIMIT 25;


SELECT COUNT(M.member_id), S.city FROM `Store` AS S 
INNER JOIN `Membership` AS M
ON S.store_id = M.store_id
GROUP BY S.city
ORDER BY COUNT(M.member_id) ASC LIMIT 25;


SELECT S.city, count(M.member_id) ,
CASE WHEN S.city > 250 THEN 'red'
     WHEN S.city < 30 THEN 'yellow' 
     ELSE 'default' END AS Backgroundcolor
FROM `Store` AS S  
INNER JOIN `Membership`
AS M
ON S.store_id = M.store_id
GROUP BY S.city;


SELECT S.city, S.address, M.store_id, count(S.city), count(M.member_id), EXTRACT(YEAR FROM M.signup_date) AS YEAR
FROM `Membership` AS M
LEFT JOIN `Store` AS S
ON M.store_id = S.store_id
GROUP BY M.store_id, YEAR
HAVING count(S.city) > 1;