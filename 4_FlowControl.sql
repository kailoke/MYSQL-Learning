# 流程控制
/*
 > 顺序结构
 > 分支结构
		> IF(expr1,expr2,expr3)
		> CASE: 表达式 或 函数体(begin end)
 > 循环结构
*/


# 一、 IF 结构
# 1.IF(expr1,expr2,expr3)  三元if简单函数
#               TRUE  FALSE		
SELECT IF( 10 > 5, '大','小');


# 2.if 分支 (begin end 函数体)
if 条件1 then 语句1;
else if 条件2 then 语句2;
...;
[else 语句else;]
end if;


# 二、 CASE 结构
# > 可作为 表达式  或  过程\函数语句(位于函数体begin end中)
/*
 语法
	CASE [case_field]
		WHEN condition1 THEN 	statement_list1
		WHEN condition2 THEN 	statement_list2
		ELSE 									statement_list_else
	END [case](函数使用，表达式不能用)
*/

# > 作为表达式，整个表达式是一句话：statement 不能用 ; 结尾
# > 作为函数体，执行语句就是一句话：statement 必须用 ; 结尾

# 2.1 等值判断，需要 case 字段
SELECT last_name,salary 原始工资,  # 表达式本身就是字段
CASE department_id
	WHEN 30 THEN salary * 1.1
	WHEN 40 THEN salary * 1.3
	WHEN 50 THEN salary * 1.5
	ELSE salary
END AS 新工资
FROM employees;

# 2.2 区间判断， 在when 中指明字段
/* 案例：查询员工工资级别
工资 > 20000， A级
工资 > 15000， B级
工资 > 10000,  C级
其他  D级
*/
SELECT last_name,salary,
case
	when salary > 20000 then '高级'
	when salary > 15000 then '中级'
	when salary > 10000 then '一般'
ELSE "D" END AS 工资级别
FROM employees;

# 2.3 作为函数体 (begin end)
/* 案例：创建存储过程，根据传入成绩显示等级
		90-100: A
		80-90 : B
		60-80 : C
		else  : D
*/
create procedure showgrade(in score int)
begin
	case
		WHEN score BETWEEN 90 and 100 then SELECT "A";
		WHEN score >=80 then SELECT "B";
		WHEN score >=60 then SELECT "C";
		else select "D";
	end case;
END

call showgrade(71);

