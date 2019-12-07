# 进阶2: 条件查询
/*
一、语法：
	SELECT 
			查询表名 	③
	FROM
			表名 			①first EXECUTE
	WHERE			筛选条件; ②second EXECUTE
二、结果
	WHERE 结束后生成结果集，所以紧跟from table

三、分类
	> 1. 按条件表达式筛选: < > = (!= <>) <= >=
	> 2. 按逻辑表达式筛选：AND OR NOT
	> 3. 模糊查询
		> LIKE
		> BETWEEN AND
		> IN
		> IS NULL		null值参与运算符会直接被忽略
*/

# unknown column "sal_total". 因为where是对table内的值进行条件筛选
SELECT salary*10 as sal_total, last_name as name
FROM employees
WHERE sal_total > 50000;  

# 1 条件表达式
# 案列1.1：筛选工资>12000的员工信息
SELECT * FROM employees WHERE salary > 12000;

# 案列1.2：查询部门编号不等于90的员工名和部门编号
SELECT last_name,department_id FROM employees WHERE department_id <> 90;


# 2 逻辑表达式
# 案例2.1: 查询10000<=工资<=20000的员工名、工资及奖金
select last_name,salary,commission_pct FROM employees WHERE salary>=10000 and salary<=20000;

# 案例2.2: 查询部门编号不在90-110之间，或者工资高于15000的员工信息
SELECT * from employees WHERE department_id < 90 OR employees.department_id > 110 OR employees.salary > 15000;


# 3 模糊查询
/*
1. LIKE ： 一般和通配符搭配使用，可以判断字符型或数值型
	> % 任意多个字符，包含0个
	> _ 任意单个字符
	> ESCAPE 指定转义字符  '_@_%' escape '@'
	> \ 转义字符		'_\_%'
	
2. BETWEEN x AND y:	x =< 条件字段 =< y

3. IN: 判断字段值是否属于 IN 列表中的一项
			IN 列表的值类型必须统一 或 兼容
			
4. >IS NULL:		空		仅用于判断是否为null值
	 >IS NOT NULL	非空	(=  !=) 运算符不能判断null值
	
5. <=>	: 安全等于。 可同时作用于 = 和 NULL

*/
# 3.1 查询员工名字中包含字符 a 的员工信息
SELECT * FROM employees WHERE last_name LIKE '%a%';	# 中间有a
SELECT * FROM employees WHERE last_name LIKE 'a%';	# a开头


# 3.2 查询员工编号在100-120之间的员工信息
SELECT * FROM employees WHERE employee_id BETWEEN 100 AND 120;

# 3.3 查询员工编号是 IT_PROG、AD_VP、AD_PRES中的一个的 员工名和工种编号
SELECT last_name,job_id FROM employees WHERE job_id in ('IT_PROG','AD_VP','AD_PRES');

# 3.4 查询没有奖金员工名和奖金率
SELECT last_name,commission_pct FROM employees WHERE commission_pct IS NOT NULL;

SELECT last_name,salary,commission_pct FROM employees WHERE commission_pct <=> null;

