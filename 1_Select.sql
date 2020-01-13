# 基础查询 SELECT
/*
一、语法:
	> SELECT * | { [Distinct] column|expression [[AS] alias],...}
		FROM	table;
二、作用：对分组数据进行函数调用，对`最终结果集`集合输出
三、特性:
	> 1. 可查询列表内容：表的列、表达式、函数、常量值
	> 2. alias：列的别名，需紧跟列名，对where结果集进行列重命名
			* 列名和别名间使用关键字AS，别名使用"双引号"，以便别名使用空格或特殊字符
	> 3. `Name`：着重号，指定着重号内的字符串为字段名，不会和关键字冲突
*/

# 1. 描述表结构
DESC employees;

# 2. 查询表中的字段
SELECT * FROM employees;			# '*' 是SQL中的通配符
SELECT last_name FROM employees;
SELECT last_name,salary,email FROM employees;

# 3. 查询常量值 : 虚拟表增加常量值的列，列名和行值=常量
SELECT 100;		# 
SELECT "john";

# 4. 查询表达式 : 表达式为列名，表达值结果为值
SELECT 100 % 98;

# 5. 查询函数 : 函数为列名，函数结果为值
SELECT VERSION();

# 6. 起字段别名 AS ； AS 可省略
SELECT 100 % 98 AS 结果;
SELECT last_name 姓,first_name 名 FROM employees;

# 7. 去重 [distinct] 非*查询的可选关键字
SELECT DISTINCT department_id FROM employees;

# 8. + 运算符 （SQL，+仅是数字运算符)
/*
SELECT 100 + 90 	参数均为数值，则进行+运算
SELECT "100"+90		一方参数为字符型，则试图将字符转为数值
								> 转换成功，+ 运算
								> 转换失败，字符默认=0
SELECT "kk"+90 as 结果;		== 90
SELECT null+10		一方为null,则结果为null/ CONCAT(str1,str2,...) 也如此
*/

# 8.1 concat() 连接函数(字符串)：查询 员工姓和名 连接成一个字段并显示为 姓名
SELECT CONCAT(last_name," ",first_name) FROM employees;
SELECT CONCAT(last_name," ",first_name) AS 姓名 FROM employees;
