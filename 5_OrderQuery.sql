# 排序查询

/*
一、语法
		ORDER BY Field [ASC,DESC]

二、特点
	> ASCend DESCend。默认ASC 升序
	> 支持表达式排序，支持别名排序，支持函数排序
	> 多表达式时，按声明顺序排序
	> ORDER BY一般放在查询语句最后面(limit最最后)

*/

# 案例1： 查询员工信息，按工资从低到高排序
SELECT * FROM employees order by salary ASC;

# 案列2： 查询部门编号>=90，按入职时间先后进行排序
SELECT * FROM employees WHERE department_id >= 90 ORDER BY hiredate ASC;

# 按表达式排序
# 案列3： 按年薪高地显示员工信息和年薪
SELECT *,salary*12*(1+IFNULL(commission_pct,0)) AS 年薪 FROM employees order by 年薪 ASC;

# 案列4： 按姓名长度排序员工信息
SELECT 
			CONCAT(last_name,' ',first_name) AS 姓名,
			salary,LENGTH(CONCAT(last_name,first_name)) 
FROM 
			employees 
ORDER BY 
			LENGTH(last_name) ASC;
			
# 案例5： 按工资高地排序员工信息，工资相同时则按工号排序
SELECT * FROM employees ORDER BY salary ASC, employee_id ASC;