# 联合查询
/*
一、作用：将多条查询语句的虚拟结果`拼接`成一个结果
二、语法：关键字 union [all]
		查询语句1
		union 查询语句2
		union 查询语句3
		...
		
三、特性
		> 1. 联合表字段名 = 第一个查询结果表，列顺序 = 各表排列顺序
		> 2. 被联合表的列数必须一致；类型和意义推荐一致，否则无意义
		
		> 3. 当被联合表中的行满足多个条件时，联合表中的数据会出现重置值
			> UNION 			默认去重，除去满足多个条件的行数据污染
			> UNION ALL 	不去重，没满足一个条件就产生一条记录
*/

# 查询 部门编号>90 或 邮箱中包含'a' 的员工信息
# 常规实现 67条
SELECT * FROM employees WHERE email like "%a%" or department_id > 90;

# 联合查询 67条
SELECT * FROM employees WHERE email like "%a%"UNION			
SELECT * FROM employees WHERE department_id > 90;

# 联合查询，不去重 70条: 有3条数据重复满足条件
SELECT * FROM employees WHERE email like "%a%"
UNION ALL
SELECT * FROM employees WHERE department_id > 90;



