# SQL199连接查询
/*
	1.多表查询，当查询的字段来自于多个表时使用
	2.连接条件
	3.分类:
			> 年代分类：
				> SQL192标准:仅支持内连接
				> SQL199标准(推荐)：内连接+外连接(左外+右外)+交叉连接
			> 功能分类：
				> 内连接(inner): 等值连接，非等值连接，自连接 [inner 可省略]
				> 外连接(outer)：左外连接(left outer)，右外连接(right outer），全外连接(full outer)
				> 交叉连接(cross)
	4.语法：
	SELECT 查询列表
	FROM table<name>
	[连接方式] join table<name>
	on [连接条件]
*/


# 一、INNER JOIN
# 1.1 查询员工名、部门名
SELECT last_name,department_name
FROM employees 
INNER JOIN departments
ON employees.department_id = departments.department_id;

# 1.2 查询名字含e的员工名和工种名
SELECT last_name,job_title
FROM employees INNER JOIN jobs
ON employees.job_id = jobs.job_id
WHERE last_name LIKE "%e%";

# 1.3 查询员工名、部门名、工种名，并按部门名降序
SELECT last_name,department_name,job_title
FROM employees
JOIN departments ON employees.department_id = departments.department_id
JOIN jobs ON employees.job_id = jobs.job_id
ORDER BY department_name DESC;


# 二、外连接
/*
	1.应用场景：查询主表中有，但从表中没有的记录
	2.特点：
		> 外连接结果 = 内连接结果+ (主表-内连接)*null
		> 左外和内外本质上相同，只区分主表
	3.外连接主表
		> LEFT JOIN 左主表
		> RIGHT JOIN 右主表
*/

# 2.1 查询美女表中男朋友不在 boys表的
# ↓ 从卡迪尔乘积中过滤不满足条件的....
SELECT name,boyfriend_id
FROM beauty
JOIN boys ON boyfriend_id <> boys.id;

SELECT b.`name`,bo.*
FROM beauty b LEFT JOIN boys bo
ON b.boyfriend_id = bo.id
WHERE bo.id is NULL;

SELECT b.`name`,bo.*
FROM beauty b RIGHT JOIN boys bo
ON b.boyfriend_id = bo.id;

# 2.2 查询哪个部门没有员工
USE myemployees;
SELECT departments.*,employee_id
FROM departments LEFT JOIN employees
ON departments.department_id = employees.department_id
WHERE employee_id is NULL



