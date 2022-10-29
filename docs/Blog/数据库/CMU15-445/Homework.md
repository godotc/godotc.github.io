# Homework

## 1. SQL
- Q2 string function:
```sql
SELECT 
	ShipName,
	substr(ShipName, 0 , instr(ShipName, '-')) as PreHyphen
FROM 'Order' 
WHERE ShipName REGEXP '-' 
Group by ShipName 
ORDER  BY ShipName;
```
- Q3 North America
附加一列可以直在 select 后判断
 ```sql
SELECT
 Id, ShipCountry ,
 CASE 
 WHEN  ShipCountry IN ('USA', 'Mexico', 'Canada') 
  THEN 'NorthAmerica'
  ELSE 'OtherPlace'
 END
FROM 'Order'
WHERE Id>=15445
ORDER by Id ASC
LIMIT 20; 
```

- Q4 Delay Precent
```sql
SELECT DISTINCT ShipName from 'Order' order by ShipName,
SELECT 
	ShipperName , 
	 from 'Order'
	 
SELECT ShipName from 'Order'
WHERE ShipName
Count(ShippedData>RequiredData)/Count(ShipName)
DESC by 

```

