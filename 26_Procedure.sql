# 存储过程
/*
 > 提高代码重用性
 > 简化操作
 > 减少编译次数 减少数据库服务器的连接次数
*/

# 一、创建存储过程
CREATE procedure 存储过程名(参数列表)
BEGIN
	存储过程...
	存储过程...
END

/*参数列表:
	> 参数模式
		> in		: 输入参数，需要调用方法传入参数
		> out		: 输出参数，可作为存储过程返回值
		> inout : 输入输出参数
	> 参数名
	> 参数类型
	
 * 结束符 delimiter [符号]
		> 1. 默认结束符 ;
		> 2. 指定结束符，当前会话有效
*/

# 二、调用方法
call 存储过程名(实参列表) delimiter;


# 1. 空参存储过程
# 插入到girls.admin表中五条记录
select * from admin;

delimiter $
create procedure insertFive()
BEGIN
	INSERT INTO admin(username,`password`) VALUES
		('david',0000),('rose',0000),('jack',0000),('tom',0000),('jerry',0000);
END $

# 2. in 模式参数
# 案例2.1 根据女神名，查询对应的男神信息
-- delimiter $
beauty.`name`create procedure findBoy(in beautyName VARCHAR(10))
BEGIN
	select b.id,boyName,userCP 
	FROM beauty left join boys b on beauty.boyfriend_id = b.id
	WHERE beauty.`name` = beautyName;
END $

call findboy('柳岩') $

# 案例2.2 判断用户名密码是否匹配

CREATE PROCEDURE login(in username VARCHAR(20),in password varchar(20))
BEGIN
	DECLARE result int default 0; # 声明+初始化
	
	SELECT COUNT(*) into result FROM admin
	WHERE admin.username = username
	and admin.`password` = password;
	
	SELECT IF(result > 0,'登陆成功','账号密码错误') AS 结果;
END $

# 3. out 模式参数
# 3.1 根据女神名，返回对应的男神名
CREATE procedure findBoysName(in beautyName VARCHAR(10),out boysName VARCHAR(10))
BEGIN
		SELECT boys.boyName INTO boysName 
		FROM boys
		right JOIN beauty on boyfriend_id = boys.id
		WHERE beauty.`name` = beautyName;
END $
SET @男神$ := '无'$
call findBoysName('柳岩',@男神)$
SELECT @男神$

# 3.2 根据女神名，返回对应的男神名和魅力值
CREATE procedure findgod(in beautyName VARCHAR(10), out boyName VARCHAR(10), out cp int)
BEGIN
	select boys.boyName,userCP into boyName,cp
	FROM boys
	right JOIN beauty on boyfriend_id = boys.id
	WHERE beauty.`name` = beautyName;
END $

CALL findgod('小昭',@男神,@魅力值) $
SELECT @男神,@魅力值 $

# 3.3 传入a,b 返回a,b的翻倍值
CREATE procedure `double`(INOUT numA int,INOUT numB int)
BEGIN
	SELECT numA*2,numB*2 INTO numA,numB;
	SELECT numA,numB;
	
	/*
	set numA = numA * 2;
	set numB = numB * 2;
	*/
END $

show create procedure `double`;





