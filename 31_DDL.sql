# DDL 数据定义语言
/*
	DDL: 表和库的管理
	一、库
		> 创建、修改、删除、复制(LIKE \ SELECT ...)
	二、表
		> 创建、修改、删除、复制

	> 创建：create
	> 修改：alter
	> 删除: drop
*/


# 一、库的管理
# 1.1 创建库:CREATE DATABASE 库名
CREATE DATABASE if not exists books;

# 1.2 修改库名，已被禁用
# 1.3 修改库的字符集
ALTER DATABASE books character set utf8mb4;

# 1.4 库的删除
DROP database if exists books;


# 二、表的管理
/* 语法
	CREATE TABLE 表名(
			字段1 类型1(长度1) [约束条件...],
			字段1 类型1(长度1) [约束条件...],
			字段1 类型1(长度1) [约束条件...],
			...
	)
*/

# 1. 表创建
CREATE TABLE if not exists book(
		id int(10),					# 编号
		bName VARCHAR(20),
		price double,
		authorID INT(6),
		publishDate datetime
)
INSERT INTO book VALUES (1,'jack&tom',15.00,001,'1992-03-15')

CREATE TABLE if not exists author(
		id INT,
		authorName VARCHAR(20),
		nation VARCHAR(10)
)

# 2.表修改
# ①改变(更换)字段	CHANGE
 ALTER TABLE book CHANGE COLUMN publishDate pubDate datetime;
# ②修改字段	MODIFY
 ALTER TABLE book MODIFY COLUMN pubDate TIMESTAMP;
# ③添加新列	ADD
 ALTER TABLE book ADD COLUMN annual double [first\after column<name>;
# ④删除列		DROP
 ALTER TABLE book DROP COLUMN annual;
# ⑤修改表名	RENAME TO
 ALTER TABLE book RENAME to bookInfo;
 
# 3.表删除
DROP TABLE if exists author;
SHOW TABLES;


# 4.表的复制
INSERT INTO author(authorName,nation) values
('村上春树','日本'),
('莫言','中国'),
('冯唐','中国'),
('金庸','中国');

# 4.1 复制表结构
CREATE TABLE if not exists author_copy1 LIKE author;
# 4.2 复制表结构+数据
CREATE TABLE author_copy2
SELECT * FROM author;
# 4.3 复制表部分结构+数据
CREATE TABLE author_copy3
SELECT * FROM author
WHERE nation = '中国';
# 4.4 复制表部分结构 WHERE FALSE
CREATE TABLE author_copy4
SELECT id,authorName
FROM author WHERE FALSE;




