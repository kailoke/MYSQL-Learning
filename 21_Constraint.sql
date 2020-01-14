# 约束
/*
一、作用：为保证数据的一致性和完整性，SQL规范使用约束对表数据进行条件限制
	> 约束是表级的强制规定
	> 使用环境：创建表 或 修改表字段时使用
	
二、SQL的6种约束：
	> 1.列级约束，作用于一个列上，跟在列的定义后面
		> not null：非空约束，规定该字段不能是Null
			> 空字符串 "" 和 0 不等于null
		> default ：默认值
		
	> 2.列级 || 表级约束
		> unique : 唯一约束，规定该字段在参数字段组合中是唯一的，可以是Null
			> 一个可以有多个唯一约束，多个列组合的约束
			> 若不显示指定唯一约束的列参数，则默认为本列
			> SQL默认为唯一约束的组合列唯一索引
			
		> primary key: 主键，`非空`且`唯一性`，相当于null+unique
			> 一个表中至多有一个主键
			> SQL默认为主键的组合列创建对应的唯一索引
			
		> check(expr): 满足条件表达式的值才能插入。mysql中无实际效果，不报错不警告; 
			> 列如： age int CHECK(age > 0),
	
	> 3.表级约束，作用于多个列上，onstraint 表级约束中单独定义
		> constraint keyNanme foreign key(slaveField) references table<Master>(KeyField)
			> 外键，保证设置表(从表)的foreign字段值必须参照外表(主表)的关联列或为null
			> 外表的关联列必须是`key`(主键、唯一、外键)
			> 两表关联类的数据类型要求一致或兼容
			> 主表的记录若被从表数据参照，则主表的记录不允许删除
				> 需要先移除从表中依赖于被参照记录的数据后，才能删除主表的数据
			
	> 级联删除 on delete cascade
		> constraint foreign key(field) references table(field) ON DELETE cascade
		> 当主表中的列被删除时，从表的对应列也被删除
	> 删除置空 on delete set null
		> constraint foreign key(field) references table(field) ON DELETE set null
		> 当主表中的列被删除时，从表的对应列置空
	
# unique 和 主键比较：

				唯一性		can null						一个表中		组合键
				
主键		√						×									至多一个		√，不推荐
唯一		√					√(仅能有一个null)		任意个			√，不推荐

三、约束的添加：
	> 1. 列级约束
			> foreign key 无效果
			> check() 无效果
	> 2. 表级约束
			> not null \ default 不能使用
			> constraint 别名，一般应用于外键，通过别名区分外键引用
	> 3. primary key && unique 既是列级约束，也可以是表级约束(组合键)
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

# 2.查看表结构
DESC student;
# 查看表索引 : 包括 主键、外键、唯一、自定义索引
show index FROM student;
drop TABLE if exists student;

# 查看creat table 语句
SHOW CREATE TABLE jobs;


# 3. 表级约束
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
		UNIQUE(seat,major),
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


# 二、 修改字段约束
# not null \ default 纯列级约束
alter TABLE student2 modify column xxx null;
# unique \ primary key \ check 支持列级+表级约束
alter TABLE student2 add PRIMARY KEY(field);
# constraint 别名 foreign key(field) references table.(field) 仅支持表级约束
alter TABLE student2 ADD constraint 别名 foreign KEY(fiedl) REFERENCES major(id);


# 三、 约束
DESC student2;
show index FROM student2;
# not null \ default \ auto_increment纯列级约束指定时会完全覆盖旧值
alter TABLE student2 modify column stuName VARCHAR(10);
alter table student2 modify column seat int;
# 删除主键约束
alter table student2 DROP PRIMARY key;
# 删除唯一约束
alter TABLE student2 DROP index field;
# 删除外键约束
alter table student2 drop foreign key 外键名


