## SQL lang

### DISTINCT 
用在 select 后, 用于去重单行的结果, 但是对于多col 数据 针对某一col去重就不行了,这时候需要用到 `GROUP by`
```sql
select DISTINC id,name from tb;
```
### GROUP 
```sql
select id,name from tb GROUP by id;
```

### JOIN
![](attachments/sql-join.png)
