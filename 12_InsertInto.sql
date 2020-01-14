# DML 数据操纵语言 Data Manipulation Language
/*
	insert into table(fieldSet) values(valueSet)
	update table set field1=value1,field2=value2,... where
	delete from table where
*/

# INSERT INTO
/* 
一、语法：
	> insert into table(Fields) values(value[]),(value[]), ...
			> 省略表字段值则默认为全字段
			> 支持多条values语句插入多行
	> insert into table set field1=value1,field2=value2,...
		
二、拷贝数据插入；支持子查询，将子查询结果作为values直接传参
	> !!! 不需要values !!!
	> INSERT INTO table(fields)
		SELECT()
*/

# 一、语法
# 1. 经典插入
INSERT INTO beauty(beauty.id,beauty.`name`,beauty.sex,beauty.borndate,beauty.phone,beauty.photo,beauty.boyfriend_id)
VALUES(13,'唐艺昕','女','1990-4-23','18988885623',NULL,2);

# 2. set插入，使用较少
INSERT INTO beauty
set id=15,`name`='刘涛',phone = '999';

INSERT INTO beauty
set `name`='黄月英',phone = '999';

# 二、特性
# 1. 插入null值
# 显示指定：table(fields) VALUES (null, ...)
# 隐式默认：table不包含的字段，隐式指定其值null

# 2. 省略列名则默认为表的`所有`列(包含键)
INSERT INTO boys VALUES(5,'张飞',13)

