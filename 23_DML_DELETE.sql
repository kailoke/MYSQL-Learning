# 删除语句
/*
一、单表删除
	DELETE FROM 表名
	WHERE 筛选条件
	LIMIT off,size;
	
二、级联删除
	DELETE 表名1或别名1,表名2或别名2(需要删除的表)
	FROM 表名1 别名
	[连接类型] JOIN 表名2 别名2 ON [连接条件]
	WHERE 筛选条件
	
	> delete 返回影响的行数
	> delete 可以回滚
	
三、表清空:清空表数据
	TRUNCATE table 表名
		> 不允许搭配where，直接清空表中数据
		> TRUNCATE后，表的自增列将被重置
		> truncate 没有返回值
		> truncate 不能回滚
*/

# 一、delete 单表删除
# 1.1 删除 beauty_copy1表 中手机号以 9 结尾的记录
DELETE FROM beauty_copy1
WHERE phone LIKE "%9";


# 二、delte 多表删除
# 1.2 删除 张无忌 女友信息
DELETE beauty_copy1 FROM beauty_copy1
INNER JOIN boys_copy1 ON beauty_copy1.boyfriend_id = boys_copy1.id
WHERE boys_copy1.boyName = '张无忌'


# 三、truncate 清空表
truncate TABLE beauty_copy2