# DELETE FROM
/*
一、单表数据删除
	> delete from 表名
		where 筛选条件
		LIMIT off,size;
	
二、级联表数据删除
	>	DELETE 表名1|别名1,表名2|别名2(需要删除数据的表)
		FROM 表名1 别名
		[连接类型] JOIN 表名2 别名2 ON [连接条件]
		WHERE 筛选条件
	
	> delete 返回影响的行数Affected rows
	> delete 可以回滚
	
三、DDL：表重置 truncate table 表名;
	> 直接重置表为创建状态
	> truncate后，表的自增列将被重置
	> truncate 没有返回值
	> truncate 不能回滚
*/

# 一、delete 单表数据删除
# 1.1 删除 beauty_copy1表 中手机号以 9 结尾的记录
DELETE FROM beauty_copy1
WHERE phone LIKE "%9";


# 二、级联表数据删除
# 1.2 删除 张无忌 女友信息
DELETE g FROM beauty_copy1 g
	INNER JOIN boys_copy1 b ON g.boyfriend_id = b.id
WHERE b.boyName = '张无忌';

# 三、truncate 重置表
truncate TABLE beauty_copy2

