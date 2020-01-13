# 子查询
/*
一、概念：
	> 子查询(内查询)：出现在其他语句内部的select语句
	> 主查询(外查询)：内部嵌套其他select语句的查询
二、使用：
	> 1.首先执行子查询
	> 2.子查询使用 () 括号包裹，子查询放在比较条件的右侧
	> 3.单行比较操作符 --> 单行子查询: < > = <= >= <>
	> 4.多行比较操作符 --> 多行子查询: in\not in any|some all
三、分类：根据结果行数
	> 1.单行子查询
		> 标量子查询:一行一列
		> 行子查询  :一行(多列)
	> 2.多行子查询
		> 列子查询  :一列(多行)
		> 表子查询  :多行多列
		
四、相关子查询函数: exists(select...)，检查子查询结果是否非null
		> EXISTS() 存在结果则为1，不存在则为0
		> 函数执行优先级，过滤false
		
五、常见位置区分：
	> SELECT <标量子查询>
	> FROM <表子查询>
	> WHERE / HAVING <单行子查询、多行子查询>		
*/

# 一、单行子查询
# 1.1 谁的工资比Abel高？
SELECT salary FROM employees WHERE last_name = "Abel"; # Abel的工资

SELECT * FROM employees
WHERE salary > (		# salary > select salary from Abel
	select salary FROM employees WHERE last_name = "Abel"
);

# 1.2 job_id与141号员工相同，salary比143号员工多的 员工 姓名，job_id，工资
SELECT last_name,job_id,salary
FROM employees
WHERE job_id = (
	select job_id FROM employees WHERE employee_id = 141
) AND salary > (
	select salary FROM employees WHERE employee_id = 143
);

# 1.3 公司工资最少的员工的 姓名，职业，和薪资
SELECT last_name,job_id,salary		# 标量
FROM employees
WHERE salary = (
	select MIN(salary) FROM employees
);

# 1.4 最低工资>50号部门最低工资的 部门id和其最低工资
SELECT department_id,MIN(salary)	# 标量
FROM employees
GROUP BY department_id
HAVING MIN(salary) > (
	select MIN(salary) FROM employees
	WHERE department_id = 50);

# 1.5 查询员工编号最小并且工资最高的员工信息
SELECT * FROM employees		# 两个标量子查询
WHERE salary = (
	select max(salary) FROM employees)
AND employee_id = (
	select min(employee_id) FROM employees);

SELECT * FROM employees		# 行子查询
WHERE (salary,employee_id) = (
	select MAX(salary),MIN(employee_id)
	FROM employees);


# 二、 多行子查询
# 2.1 返回location_id是 1400 或 1700 的部门中所有员工姓名
SELECT last_name,location_id,e.department_id  # where实现
FROM employees e
	left join departments d on e.department_id = d.department_id
WHERE location_id in (1400,1700);

SELECT last_name,department_id								# 多行子查询
FROM employees
WHERE department_id in (
	select department_id FROM departments
	WHERE location_id in (1400, 1700));

# 2.2 返回其他部门中比job_ib为"IT_PROG"部门任一工资低的员工的 工号、姓名、job_id、salary
SELECT employee_id,last_name,job_id,salary,department_id
FROM employees
WHERE salary < ANY(
	SELECT DISTINCT salary FROM employees
	WHERE job_id = "IT_PROG") 
AND job_id <> "IT_PROG";		# 76条记录

SELECT employee_id,last_name,job_id,salary,department_id
FROM employees
WHERE salary < ANY(
	SELECT DISTINCT salary FROM employees
	WHERE job_id = "IT_PROG")
AND department_id <> (			# 75条记录 null参与运算符会直接被忽略
	SELECT DISTINCT department_id FROM employees
	WHERE job_id = "IT_PROG");


# 三、标量子查询
# 3.1 查询每个部门的员工数
SELECT * FROM departments 		# 自外连接，显示没有员工的部门
	LEFT JOIN (
		SELECT department_id,COUNT(*) FROM employees
		GROUP BY department_id) AS target 
	ON departments.department_id = target.department_id;

SELECT d.*,(									# 标量子查询，每一行都拿到对应的标量
	SELECT count(*) FROM employees e
	WHERE e.department_id = d.department_id) as 员工个数
FROM departments d;

# 3.2 查询有员工号=102的部门名
SELECT employee_id,(
	SELECT department_name FROM departments
	WHERE department_id = (
		SELECT department_id FROM employees
		WHERE employee_id = 102)
	) AS 部门名
FROM employees
WHERE employee_id = 102

# 四、exists :相关子查询
select exists(select employee_id FROM employees WHERE salary = 3000)  # 1

# 4.1 查询有员工的部门名
SELECT department_name
FROM departments d
WHERE EXISTS (
	SELECT * FROM employees e
	where d.department_id = e.department_id
	)