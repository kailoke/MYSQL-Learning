# SQL199连接查询
/*
一、SQL199连接条件格式: (TYPE JOIN table ON condition)
二、MySQL199标准支持：内连接 + 外连接(左外+右外) + 交叉连接
三、分类：
	> 内连接[inner]: 查询主表元素的查询目标在从表中的所有记录
		> 等值连接：ON条件是 '='
		> 非等值连接：ON条件没有 '='
		> 自连接 ：ON条件的表相同
			
	> 外连接[outer]：查询主表元素的查询目标不论是否在从表中的所有记录
		外连接结果 = 内连接结果 + (主表 - 内连接) * null : 主表在从表中无匹配则用null填充
		> 左外连接(left [outer])：left左侧为主表
		> 右外连接(right [outer])：right右侧为主表
		> !全外连接!(full [outer])：MYSQL不支持全外连接
		
	> 交叉连接(cross): 笛卡尔乘积...两表乘积，没有 ON 连接条件

三、SQL199语法：
	SELECT 查询列表
	FROM table<name>
		[连接方式] join table<name> on [表连接条件]
		[连接方式] join table<name> on [表连接条件]
	...
*/

# 一、内连接
# 1.1 查询员工名、部门名
SELECT last_name,department_name
FROM employees 
	inner join departments on employees.department_id = departments.department_id;

# 1.2 条件过滤：查询名字含e的员工名和工种名
SELECT last_name,job_title
FROM employees 
	inner join jobs on employees.job_id = jobs.job_id
WHERE last_name LIKE "%e%";

# 1.3 查询 部门员工数>3的部门名和员工数，按个数降序排序
SELECT e.department_id,department_name,count(*) as 个数
FROM employees e inner join departments d on e.department_id = d.department_id
GROUP BY e.department_id
HAVING 个数 > 3
ORDER BY 个数 DESC;

# 1.4 多表连接：查询员工名、部门名、工种名，并按部门名降序
SELECT last_name,department_name,job_title
FROM employees
	join departments on employees.department_id = departments.department_id
	join jobs on employees.job_id = jobs.job_id
ORDER BY department_name DESC;

# 1.5 非等值连接: 查询员工工资等级
SELECT employee_id,salary,grade_level
FROM employees e
	join job_grades g on e.salary between g.lowest_sal and g.highest_sal;


# 二、外连接
# 2.1 查询女神表没有男神的女神信息
SELECT g.`name`,b.*		# 2.1.1 外连接结果集
FROM beauty g 
	left join boys b on g.boyfriend_id = b.id;

SELECT g.`name`				# 2.1.2 筛选从表信息为null的行
FROM beauty g 
	left join boys b on g.boyfriend_id = b.id
WHERE b.id is null;

SELECT g.id,g.name,g.boyfriend_id
FROM beauty g
	left join boys b on g.boyfriend_id <> b.id;

SELECT b.`name`,bo.*		# 男孩做主表错误，因为男孩表中每个元素都有匹配
FROM beauty b 
	right join boys bo on b.boyfriend_id = bo.id;

# 2.2 查询没有员工的部门
SELECT d.*,e.employee_id
FROM departments d
	left join employees e on d.department_id = e.department_id
WHERE employee_id is NULL

# 3 全外连接: 左外连接 + 右外连接 - 重复的内连接
SELECT g.*,b.*
FROM beauty g
	full join boys b on g.boyfriend_id = b.id;


# 三、交叉连接: 
SELECT g.*,b.*
FROM beauty g
	cross join boys b;
