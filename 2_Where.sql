# 条件查询 : WHERE
/*
一、语法：
	SELECT 
			查询内容 	③third EXECUTE
	FROM
			表名 			①first EXECUTE
	WHERE			筛选条件; ②second EXECUTE
			
二、作用 : 对from组装的原始数据表进行过滤，过滤后调用表达式
	> Where 条件字段必须来自原始表，一定放在 FROM 子句之后

三、条件运算符
	> 1. 比较运算符: <	>	=	 <=	>=  (!= <>)
	> 2. 逻辑运算符：AND OR NOT
	> 3. 其他运算符：
		LIKE：一般和通配符(Wildcard)搭配使用，可以判断字符型或数值型
			> %	任意多[0~无限大)个字符
			> _	任意`1`个字符
			> \ 转义字符	'_\_%' = '_"_"%'
			> ESCAPE 指定转义字符  '_@_%' escape '@' 将@指定为转义字符
	
	  BETWEEN x AND y :	>= x AND <= y

	  IN(Set) 是否=set集合任一，set列表的值类型必须统一 或 兼容
			
		IS NULL 		空值	= && != 运算符不能判断null值
		IS NOT NULL	非空	SQL中使用is null && is not null 判断null值
	
		<=>	: 安全等于	结合 = 和 null值 判断的运算符
*/

# Where的过滤字段必须来自原始表，因为where是对原始表进行条件筛选
SELECT salary*10 as sal_total, last_name as name
FROM employees
WHERE sal_total > 50000;	# WHERE "sal_total" > 5000报错

# 一、条件表达式
# 1.1 工资 > 12000的员工信息
SELECT * FROM employees WHERE salary > 12000;

# 1.2 部门编号不等于 90 的员工名和部门编号
SELECT last_name,department_id FROM employees WHERE department_id != 90;

# 二、逻辑表达式
# 2.1 10000 <= 工资 <= 20000的员工名、工资及奖金率
select last_name,salary,commission_pct FROM employees WHERE salary >= 10000 and salary <= 20000;

# 2.2  部门编号不在 90-110 之间，或者工资高于15000的员工信息
SELECT * from employees WHERE department_id < 90 OR employees.department_id > 110 OR employees.salary > 15000;

# 三、其他表达式
# 3.1 员工名字中包含字符 a 的员工信息
SELECT * FROM employees WHERE last_name LIKE "%a%";	# a开头|中间有a|a结尾 = 56
SELECT * FROM employees WHERE last_name LIKE 'a%';	# a开头 = 4

# 3.2 查询员工编号在100-120之间的员工信息
SELECT * FROM employees WHERE employee_id BETWEEN 100 AND 120;

# 3.3 查询员工编号是 IT_PROG、AD_VP、AD_PRES中的一个的 员工名和工种编号
SELECT last_name,job_id FROM employees WHERE job_id IN ('IT_PROG','AD_VP','AD_PRES');

# 3.4 查询没有奖金员工名和奖金率
SELECT last_name,commission_pct FROM employees WHERE commission_pct IS NOT NULL;			# 35

SELECT last_name,salary,commission_pct FROM employees WHERE commission_pct <=> null;	# 72

SELECT COUNT(*) from employees;	# 107
