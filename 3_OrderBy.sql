# 排序查询 : ORDER BY
/*
一、语法：
		ORDER BY 条件 [ASC,DESC], ...	
二、作用：所有(select函数)调用后，对其结果集进行排序
三、特性：
	> 1. 排序条件有：列名(别名)、表达式、函数
	   * 有多个排序条件时，按条件声明顺序排序
	> 2. 条件排序方式：ASCend DESCend。不显示指定则默认 = "ASC"
	> 3. order by一般放在select语句结尾(limit最最后)
*/

# 一、单条件排序
# 1.1 查询员工信息，按工资从低到高排序
SELECT * FROM employees order by salary ASC;

# 1.2 查询部门编号 >= 90，按入职时间进行排序
SELECT * FROM employees WHERE department_id >= 90 ORDER BY hiredate DESC;

# !!!使用未被select输出的字段进行排序，则排序应在select输出前
# 1.3 表达式排序 : 按年薪升序显示 员工信息和年薪
SELECT first_name,last_name,salary * 12 * (1 + IFNULL(commission_pct,0)) AS 年薪 FROM employees order by email;

# !!!使用调用后的字段进行排序，则排序应在select函数调用后
# 1.4 函数排序 : 按姓名长度排序员工信息，条件来自select 虚拟表
SELECT 
			CONCAT(last_name,' ',first_name) AS 姓名,
			salary,LENGTH(CONCAT(last_name,first_name)) 
FROM 
			employees 
ORDER BY 
			LENGTH(姓名) ASC;

# 二、多条件排序
# 2 工资升序排序员工信息，工资相同时则工号降序
SELECT * FROM employees ORDER BY salary ASC, employee_id DESC;
