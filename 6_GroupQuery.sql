# 分组查询 搭配分组函数
/*
 > 1.分组查询自动按分组字段ASC排序
	 2.						数据源		关键字
	 分组前筛选		原始表		GROUP BY
	 分组后筛选		结果集		HAVING(分组函数作为表达式)
	 
	 3.可按多个字段分组
*/





# 1.查询每个部门的平均工资
SELECT AVG(salary),department_id FROM employees GROUP BY department_id;
SELECT ROUND(AVG(salary),2) as avg_sal,department_id FROM employees GROUP BY department_id ORDER BY department_id;

# 2.查询邮箱中包含字符 a 的，每个部门的平均工资
SELECT department_id,AVG(salary),email FROM employees WHERE email LIKE "%a%" GROUP BY department_id;

# 3.查询每个领导下属有奖金的员工最高工资
SELECT last_name,MAX(salary) FROM employees WHERE commission_pct is not NULL GROUP BY manager_id;

# 复杂筛选： HAVING 表达式:对分组后的结果(分组后的结果字段名已经改变)追加条件
# 4. 查询 哪个部门的员工个数 > 2
# 4.1 获得每个部门员工数
SELECT department_id,COUNT(*) AS 个数 FROM employees GROUP BY department_id;
# 4.2 根据4.1结果查询 员工数 > 2 的部门
SELECT department_id,COUNT(*) AS 个数 
FROM employees 
GROUP BY department_id
HAVING 个数 > 2;	# HAVING 对分组后的结果追加条件

# 5. 查询每个工种有奖金、工资> 12000 的最高工资员工编号和起工资
SELECT employee_id,MAX(salary),job_id
FROM employees
WHERE commission_pct is NOT NULL
GROUP BY job_id;
HAVING MAX(salary) > 12000;

# 6. 查询领导编号>102的每个领导其下属最低工资>5000的领导编号，及其下属最低工资
SELECT manager_id,MIN(salary)
FROM employees
WHERE manager_id > 102
GROUP BY employees.manager_id
HAVING MIN(salary) > 5000;

# 7. 按员工姓名的长度进行分组，筛选员工个数>5的
SELECT LENGTH(CONCAT(employees.last_name," ",employees.first_name)) as 姓名长度,COUNT(*)
FROM employees
GROUP BY 姓名长度
HAVING COUNT(*) > 5;

# 8. 查询每个部门每个工种的员工的平均工资
SELECT department_id,job_id,AVG(salary)
FROM employees
GROUP BY department_id,job_id
ORDER BY department_id DESC;
