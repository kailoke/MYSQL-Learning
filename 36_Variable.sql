# 变量
/*
 > 系统变量		
		> 全局变量 : 服务器每次重启设定全局变量=配置文件;	修改全局变量对所有连接(会话)有效
		> 会话变量 : 一个会话或客户端的一次连接，修改会话变量仅影响此次会话(连接)
		
 > 自定义变量	
		> 用户变量 : 可变数据类型
			> 语法：set @变量名 := 值，不限定数据类型
			> 声明和使用位置：会话中任意地方
			> 作用域：当前会话有效
			
		> 局部变量 : 强数据类型(需声明)	
			> 语法： declare 变量名 数据类型 default 值
			> 声明和使用位置：仅能在begin end中，且为第一句话
			> 作用域：begin end中有效
*/

# 一、系统变量
# 1.1 查看: SHOW
# 		查看所有变量
show global|session(默认) variables
show global variables;
show session variables;	# 会话变量略多
#			查看满足条件的部分系统变量
SHOW GLOBAL|session VARIABLES LIKE "%char%"
show GLOBAL variables like '%char%'
#			查看指定系统变量
select @@global|session.系统变量名
select @@autocommit;
select @@global.transaction_isolation;

# 1.2 赋值: SET
# SET GLOBAL|SESSION .系统变量名 = 值;
# SET @@global|session .系统变量名 = 值;
SET @@autocommit = 0;
select @@autocommit;
set autocommit = 1;
select @@global.autocommit;


# 二、自定义变量
/*
	> 声明
	> 赋值
	> 使用：查看，比较，运算
*/

# 2.1 用户变量 : 可变类型
① 声明赋值
set @用户变量名 = 值;
set @用户变量名 := 值;
select @用户变量名 := 值;
② 修改值
# 方式一: 指定值
	set @用户变量名 = 值;
	set @用户变量名 := 值;
	select @用户变量名 := 值;
# 方式二: 使用表值，值为标量查询
	select 字段 into 变量名 FROM 表;
③ 查看
SELECT @用户变量名;


# 2.2 局部变量 : 声明类型
① 声明
declare 变量名 类型
① 声明初始化
declare 变量名 类型 default 值;
② 赋值 set不用@
# 方式一: 指定值
	set 用户变量名 = 值;
	set 用户变量名 := 值;
	select @用户变量名 := 值;
# 方式二: 使用表值，值为标量查询
	select 字段 into 变量名 FROM 表;
③ 查看
select 局部变量名



