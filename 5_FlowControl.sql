# 流程控制
/*
一、顺序结构
二、分支结构
	> 1. IF函数 ：IF(expr,stateTrue,stateFalse)
	> 2. if结构 ：只能作为函数体{BEGIN (CASE END CASE) END}
		IF 条件1 then 语句1;
			else if 条件2 then 语句2;
			...;
			[else stateElse;]
		END IF; 	# 分支结构需要使用 'END 分支类型' 结束
	> 3. CASE：表达式 或 函数体{BEGIN (CASE END CASE) END}
		* 作为表达式，整个表达式是一句话：statement`不能` ; 结尾
		* 作为函数体，执行语句就是一句话：statement`必须` ; 结尾
		CASE [case_field]
			when condition1 then state1
			when condition2 then state2
			else stateElse									
		END [CASE](函数体需要END CASE，和BEGIN END区分)
三、循环结构
	> 1. while
	> 2. loop
	> 3. repeat
*/

# 一、IF函数
SELECT IF( 10 > 5, '大','小');

# 二、IF结构，仅能用于函数体中创建procedure or function
delimiter $
create function showGradeIF(score int) returns char
begin
	IF score between 90 and 100 then return "A";
	else if score >= 80 then return "B";
	else if score >= 60 then return "C";
	else return "D";
	END IF;
end $


# 三、CASE结构
# 3.1 等值判断 : CASE caseValue，则when对value进行等值判断
select last_name,salary AS 原始工资,
CASE department_id
	WHEN 30 THEN salary * 1.1
	WHEN 40 THEN salary * 1.3
	WHEN 50 THEN salary * 1.5
	ELSE salary
END 
AS 新工资
FROM employees;

# 3.2 条件判断 : 将caseValue 放在WHEN中进行条件判断
SELECT last_name,first_name,salary,
CASE
	when salary > 20000 then '高级'
	when salary > 15000 then '中级'
	when first_name LIKE "A%" then '一般'
	ELSE "低级" 
END as 工资级别
FROM employees;

/* 案例：创建存储过程，根据传入成绩显示等级
		90-100: A
		80-90 : B
		60-80 : C
		else  : D
*/
# 3.3 CASE结构作为函数体 BEGIN ... END 中
create procedure showGrade(in score int)
begin
	CASE
		when score between 90 and 100 then select "A";
		when score >=80 then select "B";
		when score >=60 then select "C";
		else select "D";
	END CASE;
end
# call procedure
CALL showGrade(90);
