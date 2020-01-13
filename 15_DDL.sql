# DDL 数据库模式定义语言
/*
一、作用：对数据库和表进行结构定义、操作方法定义等
二、管理数据库：
	> 增：create dataBase NAME;
	> 改：alter dataBase NAME...
	> 删：drop dataBase if exists NAME
三、管理表：
	> 1.create，增加表时进行结构定义：
		> create TABLE 表名(
			字段1 类型(长度) [constraint...],
			字段2 类型(长度) [constraint...],
			...
			)
	> 2.alter，修改表的结构
		> 重定义列：change column 原字段 新字段 新类型(长度)
		> 修改列类型：modify column 字段 新类型
		> 增加列：add column 字段 类型(长度) [first/after 字段]
		> 删除列：drop column 字段
	> 3.drop : drop dataBase if exists NAME
	> 4.复制表
		> like 复制表结构
		> select() 复制表结构+select数据
*/
*/

# 一、库的管理
# 1.1 创建库:CREATE DATABASE 库名
create database if not exists books;

# 1.2 修改库名，已被禁用，有数据不安全问题?
alter DATABASE books rename to book1;

# 1.3 修改库的字符集
alter DATABASE books character set utf8mb4;

# 1.4 库的删除
drop DATABASE IF EXISTS books;


# 二、表的管理
# 1. 创建表时进行结构定义
create TABLE if not exists book (
		id int(10),					# 编号
		bName VARCHAR(20),
		price double,
		authorID INT(6),
		publishDate datetime
)

CREATE TABLE if not exists author(
		id INT,
		authorName VARCHAR(20),
		nation VARCHAR(10)
)

# 向book表中添加一条记录
INSERT INTO book VALUES (1,'jack&tom',15.00,001,'1992-03-15')

# 2. 表的修改
# ①重定义字段	change
alter TABLE book change COLUMN publishDate pubDate datetime(4);
# ②修改字段类型	modify
alter TABLE book modify COLUMN pubDate TIMESTAMP;
# ③添加新列	add
alter TABLE book add COLUMN annual double first;
# ④删除列		drop
alter TABLE book drop COLUMN annual;

# 修改表名	rename to
alter TABLE book rename to bookInfo;
 
# 3. 表的删除
DROP TABLE if exists author;
SHOW TABLES;

# 4. 表的复制
INSERT INTO author(authorName,nation)
values
('村上春树','日本'),
('莫言','中国'),
('冯唐','中国'),
('金庸','中国');

# 4.1 复制表结构
CREATE TABLE if not exists author_copy1 LIKE author;

# 4.2 复制表结构+数据
CREATE TABLE author_copy2 SELECT * FROM author;

# 4.3 复制表部分结构+数据
CREATE TABLE author_copy3
SELECT * FROM author
WHERE nation = '中国';

# 4.4 复制表部分结构 WHERE FALSE
CREATE TABLE author_copy4
SELECT id,authorName
FROM author WHERE FALSE;




