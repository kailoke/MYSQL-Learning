# UPDATE
/*
	一、修改单表记录
	UPDATE table
	set 列=值,列2=值2,...
	WHERE 筛选条件
	
	二、修改多表记录
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


# 1. 修改单表记录
UPDATE beauty
SET phone = '13312341234'
WHERE `name` LIKE "唐%"

# 2. 修改表连接记录
# 2.1 修改张无忌的女朋友的手机号为 114
UPDATE beauty
INNER JOIN boys on beauty.boyfriend_id = boys.id
SET phone = '114'
WHERE beauty.boyfriend_id = '张无忌';

# 2.2 修改没有男朋友的女孩的男朋友都为张飞
UPDATE beauty
LEFT JOIN boys ON beauty.boyfriend_id = boys.id
SET boyfriend_id = (
	select id FROM boys
	WHERE boyName = '张飞'
) WHERE boys.id is NULL
