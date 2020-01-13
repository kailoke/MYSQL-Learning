# UPDATE
/*
一、修改单表记录
	> update table
		set 列=值,列2=值2,...
		where 筛选条件
	
二、修改连接表记录
SQL192:
	UPDATE 表1 别名，表2 别名
	SET 列=值,列2=值2,...
	WHERE 连接条件(必须！)
	AND 筛选条件~
	
SQL199:
 UPDATE 表1 别名
 [连接类型] JOIN 表2 别名
 ON [连接条件]
 SET ...
 WHERE 筛选条件
*/


# 一、修改单表记录
UPDATE beauty
SET phone = '13312341234'
WHERE `name` LIKE "唐%"

# 二、修改连接表记录
# 2.1 修改张无忌的女朋友的手机号为 114
UPDATE beauty
	INNER JOIN boys on beauty.boyfriend_id = boys.id
set phone = '114'
WHERE boyName = '张无忌';

# 2.2 修改没有男朋友的女孩的男朋友都为张飞
UPDATE beauty
	LEFT JOIN boys ON beauty.boyfriend_id = boys.id
SET boyfriend_id = (
	select id FROM boys
	WHERE boyName = '张飞'
) WHERE boys.id is NULL

