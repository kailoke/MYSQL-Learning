# TCL 事务控制语言Transaction Control Language 
/* 事务
一、定义：
 > 一个或一组DML语句组成一个执行单元
 > 此执行单元要么全执行，要么全不执行(若其中某一条出现错误，则整个单元回滚)

二、事务的特性 ACID
	> 1.原子性(Atomicity): 事务是一个不可分割的执行单元。要么都执行，要么都不执行
	> 2.一致性(Consistency): 事务必须使数据库从一个一致性状态 转变 到另一个一致性状态
	> 3.隔离性(Isolation): 一个事务的执行不能被其他事务干扰；并发事务之间不能互相干扰
			> 设置隔离级别
	> 4.持久性(Durability): 事务一旦被提交，则此事务对数据库中的改变是永久性的
	
三、隐式的事务：事务没有明显的开始\结束标记
	> DDL || DCL

四、显示的事务：事务具有明显的开始\结束标记
	> SHOW VARIABLES LIKE "autocommit" 查看当前会话(连接)的自动提交属性
	> 禁用DML的自动提交：SET autocommit = 0; 仅针对当前会话(连接)

	> 开启事务：insert update deleter
		SET autocommit = 0;
		start transaction;	// 有可能有的语言或者客户端没有set autocommit=0后自动开始事务
	> 结束事务
		> commit		: 提交事务
		> rollback	: 回滚事务
		> DDL || DCL (隐式事务自动提交)
		> 用户会话正常结束 || 系统异常终了
		
五、事务的隔离(Isolation)级别：一个事务与其他事务隔离的程度称为隔离级别

	> read uncommited 	: 可读取未提交的临时数据。
	> read commited			: 不可读取临时数据。但会读取字段被其他事务提交(前)后的值
	> repeatable(重复读): 确保事务可以多次从一个字段中读取相同值。当前事务持续期间禁止其他事务对这个字段进行更新
	> SERIALIZABLE			: 会话锁定读取表，当前事务持续期间禁止其他事务该表数据执行数据操纵(CUD)
												* 被禁止的事务将进入阻塞状态

	> Oracle默认 read committed，另支持serializable
	> MYSQL 默认 global/session transaction isolation level `repeatable read`
	
	> 查看当前连接的isolation变量： select @@transaction_isolation
	> 设置当前 mySQL 连接的隔离级别：set `session` transaction isolation level `read committed`
	> 设置数据库系统的全局的隔离级别：set `global` transaction isolation level `read committed`
	
六、关键字savepoint：设置回滚目标点
	> roolback to savePoint：回滚点之前的操作将会被提交
	> 语法:	
		create savePoint: savePoint PointName;
		rollback        : rollback to PointName;
*/

/*	存储引擎
一、概念：MySQL中的数据用各种不同的技术存储在文件(或内存)中
二、SHOW ENGINES 查看MySQL支持的存储引擎
三、MYSQL常用存储引擎：innodb,myisam,memory
	> innodb 支持事务
	> myisam & memory 不支持事务
*/

# 一、事务流程示例
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
set autocommit = 0;																					# 禁用DML自动提交
start transaction;
update account set balance = 500 WHERE userName = "张无忌";	# 事务语句1
update account set balance = 1500 WHERE userName = "赵敏";	# 事务语句2
# 结束事务  执行commit or rollback
-- rollback;
commit;

select * from account;



# 二、SavePoint实例
use test;
set autocommit = 0;
start transaction;
DELETE FROM account WHERE id = 2;	# 执行

savePoint testPoint;

DELETE FROM account WHERE id = 3;
rollback to testPoint;


