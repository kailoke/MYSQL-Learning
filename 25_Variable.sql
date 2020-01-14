# 变量
/*
 > 系统变量 systeam variables : @@
		> 全局变量 : SQL服务每次重启设定系统全局变量=配置文件;	修改全局变量对所有连接(会话)有效
		> 会话变量 : 一个会话或客户端的一次连接，修改会话变量仅影响此次会话(连接)
		
 > 自定义变量	
		> 用户变量(当前会话有效) : 可变数据类型  @
			> 声明并初始化：set @变量名 = 值	；set@变量 := 值；select @变量 := 值
			> 声明和使用位置：会话中任意地方
			> 作用域：当前会话有效
			
		> 局部变量(函数体中有效): 强数据类型(需声明类型)	
			> 声明： declare 变量名 数据类型 [default 值]
			> 声明和使用位置：仅能在begin end中，必须为第一句话
			> 作用域：begin end中有效
*/

# 一、系统变量，
# 1.1 查看变量: SHOW
show variables; # 查看会话变量，不显示指定时默认为 session。略多于全局变量
show global variables;	# 查看全局变量

#	1.2 查看满足条件的部分系统变量
#SHOW GLOBAL|session VARIABLES LIKE "%char%";
show GLOBAL variables like '%char%';
show variables like "autocommit";
show variables like "%isolation%";

#	1.3 查看指定系统变量
#select @@global|[@@session].系统变量名
select @@autocommit;

set session transaction isolation level read committed;
select @@session.transaction_isolation;

set global transaction isolation level read committed;
select @@global.transaction_isolation;

# 1.4 赋值: set
# set @@global|[@@session].系统变量名 = 值;
# set global|[session].系统变量名 = 值;
set @@autocommit = 1;
set autocommit = 1;

select @@autocommit;
select @@global.autocommit;
																	
set @@session.transaction_isolation = 1;	# 任何方式修改transaction 都必须指明作用域
set session transaction_isolation = 3;


# 二、自定义变量
/*
	> 声明
	> 赋值
	> 使用：查看，比较，运算
*/

# 2.1 用户变量 : 可变类型
① 声明并初始化
set @用户变量名 = 值;
set @用户变量名 := 值;
select @用户变量名 := 值;

② 修改值
# 方式一: set || select 赋值
	set @用户变量名 = 值;
	set @用户变量名 := 值;
	select @用户变量名 := 值;
# 方式二: 使用表值，值为标量查询
	select 字段 into @变量名 FROM 表;
	
③ 查看
SELECT @用户变量名;


# 2.2 局部变量 : 强类型
① 声明
declare 变量名 类型
① 默认初始化
declare 变量名 类型 [default 值];

② 赋值 set
# 方式一: set || select 赋值
	set 用户变量名 = 值;
	set 用户变量名 := 值;
	select @局部变量名 := 值;
# 方式二: 使用表值，值为标量查询
	select 字段 into 变量名 FROM 表;
	
③ 查看
select 局部变量名


# 案例 声明两个变量并赋予初始值，求和，并打印
set @a = 1;
set @b = 2;
set @a + @b;
select @sum; # select @a+@b



