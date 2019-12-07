# 联合查询
/*
	一、UNION
		> 将多条查询语句的结果合并成一个结果
	
	二、语法：
		查询语句1
		UNION
		查询语句2
		UNION
		...
	三、特性
		> 1. 多表的列数必须一致,类型和意义推荐一致，否则无意义
		> 2. 字段名 = 第一个查询，列顺序 = 各表排列顺序
		> 3. UNION 自动去重
				 UNION ALL 不去重
	
*/


# 案例  查询部门编号>90 或 邮箱中包含 a 的员工信息
SELECT * FROM employees WHERE email like "%a%" or department_id > 90;

SELECT * FROM employees WHERE email like "%a%"UNION			# 67条
SELECT * FROM employees WHERE department_id > 90;

SELECT * FROM employees WHERE email like "%a%"
UNION ALL	# 70条
SELECT * FROM employees WHERE department_id > 90;



