# 函数
/*
 > 提高代码重用性
 > 简化操作
 > 减少编译次数 减少数据库服务器的连接次数

 和存储过程区别：
	> 存储过程可以有0或多个返回值
	> 函数有且只能有1个返回值
*/

# 一、创建函数
CREATE function 函数名(参数列表) returns 返回类型
BEGIN
		函数体...
		函数体...
END
/*
 参数列表： 参数名	参数类型
 函数体：必须有return 语句，没有则报错
*/

# 二、调用语法
select 函数名(参数列表)	执行语句并显示返回值


# 案例1 无参有返回：返回公司的员工个数
create function countMembers() returns INT
BEGIN
	DECLARE c INT DEFAULT 0;
	SELECT COUNT(*) INTO c FROM employees;
	return c;
END !

select countMembers()!

# 案例2.1 根据员工名，返回工资
create function getSalary(name VARCHAR(10)) returns DOUBLE
BEGIN
		set @salary := 0; # 定义用户变量
		select salary into @salary FROM employees
		WHERE name = employees.last_name;
		return @salary;
END !

SELECT getSalary("Lorentz")!


# 案例2.2	根据部门名，返回部门的平均工资
delimiter !
create function getdeptAvg(deptName VARCHAR(20)) RETURNS DOUBLE
BEGIN
	SELECT AVG(salary) into @salary FROM employees e
	JOIN departments d on e.department_id = d.department_id
-- 	GROUP BY department_id
	WHERE department_name = deptName;
	return @salary;
END !
SELECT getdeptAvg("Adm")!


# 三、函数的删除
DROP;




