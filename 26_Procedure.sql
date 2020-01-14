# 存储过程 procedure
/*
 > 提高代码重用性
 > 简化操作
 > 减少编译次数 减少数据库服务器的连接次数

一、创建存储过程
	>	CREATE procedure 存储过程名(参数列表)
		BEGIN
			函数体...
			函数体...
		END

	> 参数列表([model] name type)
		> 参数模式
			> in		: 输入参数，调用方法必须传入参数
			> out		: 输出参数，可作为存储过程返回值
			> inout : 输入输出参数，必须要传入值，可以返回值
		> 参数名	: 实参列表若有 @变量 则自动创建
		> 参数类型
	
	> * 结束符 delimiter [符号]
		> 1. 默认结束符 ;
		> 2. 指定[符号]为结束符，当前会话有效


二、调用存储过程：call procedure<name>([model] name type)
	> 实参列表若有 @变量 则自动创建
	
三、删除存储过程：drop procedure pName (只能一次删除一个)

四、查看存储过程的逻辑：
	> show create procedure `double`;
	
五、存储过程的逻辑语句不能修改(预编译)
*/

# 一、空参存储过程
# 插入到girls.admin表中五条记录
select * from admin;

delimiter $
create procedure insertFive()
BEGIN
	INSERT INTO admin(username,`password`) VALUES
		('david',123),('rose',234),('jack',345),('tom',456),('jerry',567);
END $

call insertFive() $;

# 二、in 模式参数
# 案例2.1 根据女神名，查询对应的男神信息
drop procedure if exists findBoy;
delimiter $
create procedure findBoy(in beautyName VARCHAR(10))
BEGIN
	SELECT beautyName,b.id,boyName,userCP 
	FROM beauty
		LEFT JOIN boys b ON beauty.boyfriend_id = b.id
	WHERE beauty.`name` = beautyName;
END $

call findboy('柳岩');
call findboy('周芷若');

# 案例2.2 判断用户名密码是否匹配
drop procedure if exists login;
delimiter $
create procedure login(in username VARCHAR(20),in password varchar(20))
BEGIN
	declare result int default 0; # 声明+初始化
	
	select COUNT(*) into result FROM admin
	WHERE admin.username = username
		and admin.`password` = password;
	
	SELECT IF(result > 0,'登陆成功','账号密码错误') AS 结果;
END $

call login("john",8888);

# 三、out 模式参数
# 3.1 根据女神名，返回对应的男神名
delimiter $
CREATE procedure findBoysName(in beautyName VARCHAR(10),out boysName VARCHAR(10))
BEGIN
		SELECT boys.boyName INTO boysName 
		FROM boys
		right JOIN beauty on boyfriend_id = boys.id
		WHERE beauty.`name` = beautyName;
END $
SET @男神$ := '无';
call findBoysName('周芷若',@男神);
SELECT @男神;

# 3.2 根据女神名，返回对应的男神名和魅力值
delimiter $
CREATE procedure findgod(in beautyName VARCHAR(10), out boyName VARCHAR(10), out cp int)
BEGIN
	select boys.boyName,userCP into boyName,cp
	FROM boys
	right JOIN beauty on boyfriend_id = boys.id
	WHERE beauty.`name` = beautyName;
END $

CALL findgod('王语嫣',@男神,@魅力值);	# call() 参数列表有@用户变量，则自动创建@用户变量
SELECT @男神,@魅力值;

# 3.3 传入a,b 返回a,b的翻倍值
delimiter $
create procedure `double`(inout numA int,inout numB int)
BEGIN
	SELECT numA * 2,numB * 2 INTO numA,numB;
-- 	SELECT numA,numB;
	
	/*
	set numA = numA * 2;
	set numB = numB * 2;
	*/
END $

set @a := 1;
set @b := 2;
call `double`(@a,@b);
SELECT @a,@b;



