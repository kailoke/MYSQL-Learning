# 约束
/*
一、定义：
	> 用于限制字段数据
	> 创建表 或 修改表字段时使用
	
二、约束方法：
		列级:
	> not null:非空，保证该字段不为空
	> default :默认值
	
	> primary key: 主键，该字段值具有唯一性 并且 非空
	> unique : 唯一，该字段值具有唯一性 可以为空
	> check(): mysql中无实际效果，兼容不报错; 满足检查条件的值 才能插入
	
		表级：
	> foreign key references table<name>(field)
			> 外键，保证设置表(从表)的foreign字段值必须来外表(主表)的关联列
			> 两表关联类的数据类型要求一致或兼容
			> 外表的关联列必须是 key(主键、唯一、外键)
			
			> 级联删除 constraint foreign key(field) references table(field) ON DELETE cascade
			> 删除置空 constraint foreign key(field) references table(field) ON DELETE set null
	
	> auto_increment 自增
三、添加类型：
	> 1. 列级约束
			> foreign key 无效果
			> check() 无效果
	> 2. 表级约束
			> not null \ default 不能使用
			> constraint 别名 ， 可省略别名功能
			> 一般应用于外键，通过别名区分外键引用
*/


# 一、 创建表时添加约束
# 1. 添加列级约束
DROP TABLE IF exists major;
CREATE TABLE major(
		id INT primary KEY,
		majorName VARCHAR(10) not null
)
CREATE TABLE student(
		id INT PRIMARY KEY,
		stuName VARCHAR(10) not NULL,
		gender char CHECK(gender = '男' or gender = '女'),
		seat INT UNIQUE,
		age int default 10,
		major INT references major(id) # 外键
)

# 查看表结构
DESC student;
# 查看表索引 : 包括 主键、外键、唯一、自定义索引
show index FROM student;

drop TABLE if exists student;


# 2. 表级约束
drop TABLE if exists student2;
CREATE TABLE student2(
		id INT auto_increment,
		stuName VARCHAR(10),
		gender char,
		seat INT,
		age int,
		major INT,
		# 表级约束
		constraint pk PRIMARY KEY(id,stuName),
		UNIQUE(seat),
		CHECK(gender = '男' or gender = '女'),
		constraint fk_student_major FOREIGN KEY(major) REFERENCES major(id)
)

DESC student2;
show index FROM student2;

# 组合键测试:
TRUNCATE TABLE student2;
INSERT INTO student2 values (1,'j',null,null,null,null);
INSERT INTO student2 values (1,'k',null,null,null,null);
INSERT INTO student2 values (1,'j',null,null,null,null);
# 外键测试：
INSERT INTO student2 values (1,'a',null,null,null,1);

# 主键和唯一：
/*
				唯一性		can null						一个表中		组合键
				
主键		√						×									至多一个		√，不推荐
唯一		√					√(仅能有一个null)		任意个			√，不推荐
*/


# 二、 修改字段约束
# not null \ default 仅支持列级约束
ALTER TABLE student2 modify column xxx null;
# primary key \ unique 支持列级+表级约束
ALTER TABLE student2 add PRIMARY KEY(field);
# constraint 别名 foreign key(field) references table.(field) 仅支持表级约束
ALTER TABLE student2 ADD constraint 别名 foreign KEY(fiedl) REFERENCES major(id);


# 三、 删除约束
DESC student2;
show index FROM student2;
# not null \ default \ auto_increment列级约束覆盖旧值
ALTER TABLE student2 MODIFY column stuName VARCHAR(10);
alter table student2 modify column seat int;
# 删除主键
ALTER table student2 DROP PRIMARY key;
# 删除唯一
ALTER TABLE student2 DROP index field;
# 删除外键
alter table student2 drop foreign key 别名或未起别名的真名