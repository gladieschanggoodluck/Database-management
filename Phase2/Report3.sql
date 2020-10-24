CREATE TABLE IF NOT EXISTS `Product` (
  `PID` int(6) unsigned NOT NULL,
  `name` varchar(200) NOT NULL,
  `retail_price` real NOT NULL,
  `manufacturer` varchar(200) NOT NULL,
  PRIMARY KEY (`PID`)
) DEFAULT CHARSET=utf8;
INSERT INTO `Product` (`pid`, `name`, `retail_price`, `manufacturer`) VALUES
    ("1", "pc_a1", "100", "apple"),
    ("2", "pc_a2", "140", "apple"),
    ("3", "pc_a3", "160", "apple"),
    ("4", "pc_o1", "200", "orange"),
    ("5", "pc_o2", "250", "orange"),
    ("6", "pc_o3", "300", "orange"),
    ("7", "pc_b1", "180", "banana"),
    ("8", "pc_b2", "170", "banana"),
    ("9", "pc_b3", "190", "banana");


CREATE TABLE IF NOT EXISTS `Sale` (
  `PID` int(6) unsigned NOT NULL,
  `sale_date` datetime NOT NULL,
  `sale_price` real NOT NULL,
  `holiday` datetime NOT NULL,
  PRIMARY KEY (`PID`)
) DEFAULT CHARSET=utf8;

INSERT INTO `Sale` (`pid`, `sale_date`, `sale_price`, `holiday`) VALUES
    ("1", "2019-01-01", 123, "2019-10-10"),
    ("2", "2019-02-01", 126, "2019-10-10"),
    ("3", "2019-03-01", 123, "2019-10-10"),
    ("4", "2019-04-01", 125, "2019-10-10"),
    ("5", "2019-05-01", 124, "2019-10-10"),
    ("6", "2019-06-01", 112, "2019-10-10"),
    ("7", "2019-07-01", 143, "2019-10-10"),
    ("8", "2019-08-01", 160, "2019-10-10"),
    ("9", "2019-09-01", 121, "2019-10-10");

CREATE TABLE IF NOT EXISTS `Transaction` (
  `PID` int(6) unsigned NOT NULL,
  `date` datetime NOT NULL,
  `store_id` int(6) unsigned NOT NULL,
  `quantity`  int(6) unsigned NOT NULL,
  PRIMARY KEY (`PID`)
) DEFAULT CHARSET=utf8;

INSERT INTO `Transaction` (`pid`, `date`, `store_id`, `quantity`) VALUES
    ("1", "2019-01-01", 123, 3),
    ("2", "2019-02-01", 126, 4),
    ("3", "2019-03-01", 123, 5),
    ("4", "2019-04-01", 125, 3),
    ("5", "2019-05-01", 124, 4),
    ("6", "2019-06-01", 112, 6),
    ("7", "2019-07-01", 143, 6),
    ("8", "2019-08-01", 160, 9),
    ("9", "2019-09-01", 121, 11);


SELECT EXTRACT(YEAR FROM T.date) AS year,
COUNT(T.quantity) AS total_items, P.pid, P.name, 
       sum( 
        CASE WHEN S.sale_price IS NULL THEN P.retail_price * T.quantity 
        ELSE S.sale_price * T.quantity END
        ) AS total_revenue, 
       sum( 
        CASE WHEN S.sale_price IS NULL THEN P.retail_price * T.quantity 
        ELSE P.retail_price  * T.quantity * 0.75 END
        ) AS predicted_revenue, 
       sum(CASE WHEN S.sale_date = T.date THEN 1 ELSE 0 END) as discount_items
FROM `Transaction`  T
INNER JOIN`Product`  P ON T.pid = P.pid 
INNER JOIN `Sale`  S ON P.pid = S.pid
GROUP BY P.pid
HAVING ABS( total_revenue - predicted_revenue ) > 5
ORDER BY predicted_revenue DESC;
