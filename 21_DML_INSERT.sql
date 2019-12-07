# DML语言
/*
	insert
	update
	delete
*/

# 一、INSERT 经典插入
/* 1. 语法
	INSERT INTO table(FIELD(str,str1,str2,str3,...))
	VALUES (值,值2,...)
	
	2. 支持多条values多行插入
	3. 支持子查询，将子查询结果作为values直接传参
	!!!INSERT INTO table(fields)
	!!!SELECT ****
*/

# 1. 插入值的类型与列的字段类型一致或兼容
USE girls;
INSERT INTO beauty(beauty.id,beauty.`name`,beauty.sex,beauty.borndate,beauty.phone,beauty.photo,beauty.boyfriend_id)
VALUES(13,'唐艺昕','女','1990-4-23','18988885623',NULL,2);

# 2. nullable 字段插入值
# 方式一:  字段 VALUES null
# 方式二： 不要字段，不要值
INSERT INTO beauty_copy2(name,phone) values ("娜扎","13752815995");
INSERT INTO beauty(name,phone) values ("王菲2","13752815995");

# 3. 可以省略列名，默认为所有列，包含键
INSERT INTO boys VALUES(5,'张飞',13)

# 二、INSERT SET插入，使用较少
/* 语法
	INSERT INTO 表名
	SET 字段1=值, 字段2=值2, ...
*/
INSERT INTO beauty
set id=15,`name`='刘涛',phone = '999';

INSERT INTO beauty
set `name`='黄月英',phone = '999';