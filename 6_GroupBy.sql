# 分组查询 GROUP BY + 分组函数
/*
一、作用：对where及select表达式计算后的结果集进行分组，供函数调用

二、分组函数：忽略null值，因为null和任意数值计算=null
	> 1. count(expr): 统计expr不为null的记录总数，能应用于所有数据类型
	> 2. sum() | avg(): 仅能应用于数值型数据(能计算的数据类型)
	> 3. max() | min(): 能应用于所有类型数据(能排序的数据类型)
	> 4. 可搭配 distinct：去重进行分组函数。count(distinct expr) sum(distinct)

	> count(*) 任一列非空的行记录总数	count(1)对原始表增加常量列后统计常量列数
	
三、特性：
	> 1. groupBy结果集自动分组条件字段升序排序
	> 2.						数据源					关键字
	  分组前筛选		from组装表			where
	  分组后筛选		函数调用结果集	having(仅select参数条件可为表达式)
		* 能分组前筛选，则优先分组前筛选；则having条件一般是 分组函数或分组条件
	> 3. groupby 可以有多个分组条件
	> 4. 不能在where中使用分组函数

四、Having，对select函数调用的结果集进行select条件过滤
	> 1. 作用：对函数调用后的结果集进行 select参数条件 过滤
	> 2. 使用条件：只能跟Group By
	> 3. 使用条件：select使用了分组函数
	> 4. 使用条件：HAVING 后只能使用 select条件作为表达式
  
*/

# 一、简单分组查询
# 1.1 查询每个部门的平均工资
SELECT AVG(salary),department_id FROM employees GROUP BY department_id;

SELECT ROUND(AVG(salary),2) as avg_sal,department_id FROM employees GROUP BY department_id ORDER BY department_id DESC;

# 1.2 查询每个 邮箱中包含字符 a 的部门 的平均工资
SELECT department_id,AVG(salary),email FROM employees WHERE email LIKE "%a%" GROUP BY department_id;

# 1.3 查询每个领导下属有奖金的员工最高工资
SELECT last_name,MAX(salary) FROM employees WHERE commission_pct is not NULL GROUP BY manager_id;

# 二、分组筛选：HAVING 对分组运算后的结果集过滤
# 2.1 查询 哪个部门的员工个数 > 2
# 2.1.1 每个部门员工数
SELECT department_id,COUNT(*) AS 个数 FROM employees GROUP BY department_id;
# 2.1.2 员工数 > 2 的部门
SELECT department_id,COUNT(*) AS 个数 FROM employees GROUP BY department_id
HAVING 个数 > 2;

# 2.2 查询每个工种有奖金&&工资>12000的最高工资员工编号和起工资
SELECT employee_id,MAX(salary),job_id FROM employees
WHERE commission_pct is NOT NULL
GROUP BY job_id;
HAVING MAX(salary) > 12000;

# 2.3 领导编号>102的每个领导其下属最低工资>5000的领导编号，及其下属最低工资
SELECT manager_id,MIN(salary) FROM employees
WHERE manager_id > 102
GROUP BY manager_id
HAVING MIN(salary) > 5000;

# !!!能使用别名进行分组，则Having前select表示已经调用
# 2.4 按员工姓名的长度进行分组，筛选员工个数>5的
SELECT LENGTH(CONCAT(employees.last_name," ",employees.first_name)) as 姓名长度, COUNT(*) FROM employees
GROUP BY 姓名长度
HAVING COUNT(*) > 5;

# !!! where过滤后调用select表达式，groupby数据分组后进行select函数，之后having
# 2.5 查询每个部门每个工种的员工的平均工资
SELECT department_id,job_id,round(AVG(salary),2) as avg
FROM employees
GROUP BY department_id	# 自动按group条件组进行排序
HAVING job_id LIKE "a%"					# select参数能作为having条件
ORDER BY department_id;
