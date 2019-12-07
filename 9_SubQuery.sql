# 子查询
/*
	子查询 内查询
	主查询 外查询
	
一、分类：
	> 1 子查询出现的位置：
		> SELECT <标量子查询>
		> FROM <表子查询>
		> WHERE / HAVING <标量子查询、列子查询、行子查询>
		> EXISTS <SubQuery> (任意查询，相关子查询:是否有非null值)
			> EXISTS() 存在结果则为1，不存在则为0
	> 2 结果集的行列数不同：
		> 标量子查询: 结果集只有一行一列 (单行子查询)
		> 列子查询: 结果集只有一列多行	 (多行子查询)
		> 行子查询：结果集有一行多列
		> 表子查询：结果集为多行多列
*/

# 一、 WHERE/HAVING <SubQuery>
/*
① 子查询使用小括号包裹 ()
② 子查询一般放在条件右侧
③ 标量子查询，一般搭配单行操作符使用
	> > < >= <= = <>
④ 列子查询，一般搭配多行操作符使用
	> IN/NOT IN 			
	> ANY|SOME (相同) list中有一个满足
  > ALL							list中所有都满足
*/

# 一、 标量子查询
# 案例 1.1 谁的工资比Abel高？
SELECT salary FROM employees WHERE last_name = "Abel";

SELECT * FROM employees
WHERE salary > (
	SELECT salary FROM employees WHERE last_name = "Abel"
);

# 案列 1.2 返回job_id与141号员工相同，salary比143号员工多的员工 姓名，job_id，工资
SELECT last_name,job_id,salary
FROM employees
WHERE job_id = (
	SELECT job_id FROM employees WHERE employee_id = 141
) AND salary > (
	SELECT salary FROM employees WHERE employee_id = 143
);

# 案例 1.3 返回公司工资最少的员工的 姓名，职业，和薪资
SELECT last_name,job_id,salary
FROM employees
WHERE salary = (
	SELECT MIN(salary) FROM employees
);

# 案例 1.4 查询最低工资>50号部门最低工资的部门id和其最低工资
SELECT department_id,MIN(salary)
FROM employees
GROUP BY department_id
HAVING MIN(salary) > (
	SELECT MIN(salary) FROM employees
	WHERE department_id = 50
);


# 二、 多行子查询 列子查询
# 2.1 返回location_id是 1400 或 1700 的部门中所有员工姓名
SELECT last_name,location_id,employees.department_id
FROM employees LEFT JOIN departments ON employees.department_id = departments.department_id
WHERE location_id in (1400,1700);

SELECT last_name,department_id
FROM employees
WHERE department_id in (		# = ANY
	SELECT department_id FROM departments
	WHERE location_id IN (1400, 1700)
);

# 2.2 返回其他部门中比job_ib为"IT_PROG"部门任一工资低的员工的 工号、姓名、job_id、salary
SELECT employee_id,last_name,job_id,salary,department_id
FROM employees
WHERE salary < ANY(
	SELECT DISTINCT salary FROM employees
	WHERE job_id = "IT_PROG"
) AND job_id <> "IT_PROG";	# 76条记录

SELECT employee_id,last_name,job_id,salary,department_id
FROM employees
WHERE salary < ANY(
	SELECT DISTINCT salary FROM employees
	WHERE job_id = "IT_PROG"
)
AND department_id <> (			# 75条记录 null参与运算符会直接被忽略
	SELECT DISTINCT department_id FROM employees
	WHERE job_id = "IT_PROG"
);


# 三、 行子查询 一行多列 或 多行多列
# 3.1 查询员工编号最小并且工资最高的员工信息
SELECT * FROM employees
WHERE salary = (
	SELECT max(salary) FROM employees
)AND employee_id = (
	SELECT min(employee_id) FROM employees
)

SELECT * FROM employees
WHERE (salary,employee_id) = (
	SELECT MAX(salary),MIN(employee_id)
	FROM employees
)


# 四、SELECT + <标量子查询>
# 案列4.1 查询每个部门的员工数
SELECT * FROM departments LEFT JOIN (
	SELECT department_id,COUNT(*) FROM employees
	GROUP BY department_id
) AS target ON departments.department_id = target.department_id

SELECT d.*,(
	SELECT count(*) FROM employees e
	WHERE d.department_id = e.department_id
)FROM departments d;

# 案列4.2 查询员工号=102的部门名
SELECT employee_id,(
	SELECT department_name FROM departments
	WHERE department_id = (
		SELECT department_id FROM employees
		WHERE employee_id = 102
	)
) AS 部门名 FROM employees
WHERE employee_id = 102


# 五、 EXISTS 相关子查选

