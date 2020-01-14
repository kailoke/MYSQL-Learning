# 函数 function
/*
 > 提高代码重用性
 > 简化操作
 > 减少编译次数 减少数据库服务器的连接次数

一、和存储过程区别：
	> 存储过程可以有0或多个返回值，适用于批量的CU
	> 函数有且只能有1个返回值，适合做处理数据后返回结果

二、创建函数语法
	> CREATE function 函数名(参数列表) returns `返回类型`
		BEGIN
			函数体...
			函数体...
		END
	
	> 返回值：returns ·返回值类型·
	> 参数列表： 参数名	参数类型
	> 函数体：必须有`return 值` 语句，没有则报错

	> * This function has none of DETERMINISTIC, NO SQL, or READS SQL DATA in its declaration and binary logging is enabled
		> sql默认开启 binary logging，创建函数需要显示指定
		> 函数类型
			> deterministic(确定性  || not deterministic)
			> No sql       (没有sql语句)
			> reads sql data    : 只读数据
			> modifies sql data : 要修改数据
			> contains sql 			: 包含了SQL语句

二、调用语法：select 函数名(参数列表)
	> 执行语句并显示返回值（所以用select)

三、函数的删除
	> drop function fName;
	
四、查看函数逻辑
	> show create function fName;
	
五、函数的逻辑语句不能修改(预编译)
*/


# 案例1 无参有返回：返回employees表的员工个数
set global log_bin_trust_function_creators = true;
delimiter !
create function countMembers() returns int
BEGIN
	declare `count` int default 0;
	SELECT COUNT(*) INTO `count` FROM employees;
	return `count`;
END !

select countMembers() 成员个数;

# 案例2.1 根据员工名，返回工资
delimiter !
create function getSalary(name VARCHAR(10)) returns DOUBLE
BEGIN
		set @salary := 0; 	# 定义用户变量
		select salary into @salary FROM employees
		WHERE name = employees.last_name;
		return @salary;
END !

SELECT getSalary("Lorentz");
select @salary;


# 案例2.2	根据部门名，返回此部门的平均工资
drop function if exists getDeptAvg;
delimiter !
create function getDeptAvg(deptName VARCHAR(20)) returns DOUBLE
BEGIN
	declare sal double;
	SELECT AVG(salary) into sal
	FROM employees e
		JOIN departments d on e.department_id = d.department_id
-- 	GROUP BY department_id 	# syntax error，where 即只有此部门的信息，avg即此部门
	WHERE deptName = department_name;
	
	return sal;
END !

SELECT getdeptAvg("Adm");


# 案列3 查看函数逻辑
show create function getSalary;

