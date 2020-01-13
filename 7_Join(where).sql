# 连接查询
/*
一、多表查询：from 后的多个表组通过连接条件组装为一个原始表
		
二、MySQL分类：
	> MySQL192标准: 仅支持内连接
		
	> MySQL192仅支持内连接 : 主表元素的查询目标在从表中
		> 等值连接：where表筛选条件是 '='
		> 非等值连接：where表筛选条件没有 '='
		> 自连接 ：表A元素的查找目标还是在表A中
*/

# ↓ SQL192标准 内连接查询 ↓

# 一、等值连接
# 1.1 查询 女神对应的CP男神名
SELECT name,boyName
FROM beauty,boys
WHERE beauty.boyfriend_id = boys.id;

# 1.2 查询 员工对应的部门名
SELECT last_name,department_name
FROM employees,departments
WHERE employees.department_id = departments.department_id;

# 1.3 表别名：查询员工名、工种号、工种名；from直接重名了源表
SELECT last_name,e.job_id,job_title
FROM employees e,jobs j
WHERE e.job_id = j.job_id;

# 1.4 分组：查询每个城市的部门个数
SELECT COUNT(*) 个数,city
FROM departments d,locations l
where d.location_id = l.location_id
GROUP BY city;

# 1.5 多表连接：查询员工名、部门名和所在城市
SELECT last_name,department_name,city
FROM employees e,departments d,locations l
WHERE e.department_id = d.department_id
AND d.location_id = l.location_id
AND city like 's%'
ORDER BY d.department_id DESC;


# 二、非等值连接
# 查询员工的工资级别 job_grades
SELECT employee_id,salary,grade_level
FROM employees e,job_grades g
WHERE salary >= g.lowest_sal and salary <= g.highest_sal;

# 三、自连接
# 查询 员工的经理名
SELECT e1.employee_id,e1.last_name,e1.employee_id,e2.last_name
FROM employees e1,employees e2
WHERE e1.manager_id = e2.employee_id;

