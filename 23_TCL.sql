# TCL Transaction Control Language 事务控制语言
/*
一、事务：
 > 一个或一组DML语句组成一个执行单元
 > 此执行单元要么全执行，要么全不执行(若其中某一条出现错误，则整个单元回滚)

二、事务的特性 ACID
	> 1.原子性(Atomicity): 指事务是一个不可分割的工作单位。要么都执行，要么都不执行
	> 2.一致性(Consistency): 事务必须使数据库从一个一致性状态 转变 到另一个一致性状态
	> 3.隔离性(Isolation): 一个事务的执行不能被其他事务干扰；并发事务之间不能互相干扰
			> 设置隔离级别
	> 4.持久性(Durability): 事务一旦被提交，则此事务对数据库中的改变是永久性的
*/

# 存储引擎
SHOW ENGINES;
# myisam \ memory 不支持事务

/*
一、隐式事务	事务没有明显的开始\结束标记
# INSERT UPDATE DELETE
SHOW VARIABLES LIKE "autocommit";

二、显示事务	事务具有明显的开始\结束标记
# 前提：禁用 自动提交 SET autocommit = 0; 仅针对当前会话

# 2.1 开启事务 : 针对DML 语言
SET autocommit = 0;
start transaction;  # 非必须，autocommit = 0 则自动启动事务功能

# 2.2 撰写事务

# 2.3 提交事务
commit		: 提交事务
rollback	: 回滚事务
*/

CREATE DATABASE if not exists test;
USE test;
CREATE TABLE if NOT EXISTS account(
		id int PRIMARY KEY auto_increment,
		userName VARCHAR(10),
		balance double
)
alter TABLE account change column banlance balance double;
INSERT into account VALUE (null,'张无忌',1000),(null,'赵敏',1000);

SHOW VARIABLES LIKE "autocommit";
set autocommit = 0;
start transaction;
update account set balance = 500 WHERE userName = "张无忌";
UPDATE account SET balance = 1500 WHERE userName = "赵敏";
# 结束事务
-- rollback;
commit;

select * from account;

/*
三、事务的隔离级别
 > read uncommited 	: 可读取临时数据。
 > read commited			: 不读取临时数据。但会读取字段被其他事务提交(前)后的值
 > repeatable(重复读): 不读取临时数据，仅能读取事务开始时的字段值
 > SERIALIZABLE			: 会话锁定读取表，其他会话不能修改

MYSQL默认  global/session transaction isolation level REPEATABLE
Oracle默认 READ COMMITTED
*/

# 四、savepoint	设置回滚终止点
/*
	语句1
	SAVEPOINT 别名
	语句2
	rollback to 别名(SAVEPOINT)
*/



