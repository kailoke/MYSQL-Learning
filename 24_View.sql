# 视图 View
/*
一、定义：
	> 临时的虚拟表，可以和普通表一样使用
		> mysql5.1 新增特性，通过视图代码动态生成的临时数据
	> 本身保存sql逻辑，不保存查询结果，每次调用时动态生成视图
	
二、作用：
	> sql语句重用
	> 减少sql语句嵌套，提供可阅读性，步骤拆分
	> 保护源数据，仅提供必要性，从而提高数据安全性 (阻断了调用者对源数据表的访问)
	
三、语法：
	> 创建：create view vName as select()
	> 查看视图逻辑：show create view vName / 查看视图结构 desc vName;
	> 修改视图逻辑：create or replace view vName as .... / alter view vName as ...
	> 删除视图逻辑：drop view vName1,vName2,...
	
四、更新视图数据：不建议使用，增加只读权限
*/

# 一、创建/修改视图逻辑
# 查询有邮箱中包含 a 字符的员工名、部门名和工种信息
create OR replace view v1 AS		# 封装所有信息的视图
	SELECT last_name,email,department_name,job_title
	FROM employees e 
		INNER JOIN departments d ON e.department_id = d.department_id
		INNER JOIN jobs j ON e.job_id = j.job_id;

SELECT * FROM v1 WHERE email LIKE "%a%";

# 二、查看视图
show create view v1;
desc v1;				# 结构

# 三、修改视图
# 修改1：create or replace view vName as select()
create or replace view vtest as
SELECT * from jobs;
# 修改2 : alter view 视图1 as select()

# 四、删除视图
drop view 视图1，视图2，...

# 五、视图的更新，不重要
# 不能对有连接表逻辑的SQL视图进行更新，以下报错Can not modify more than one base table through a join view 'myemployees.v1'
insert into v1(last_name,department_name,job_title) values ("a",'a','a');

# 更新不含连接表逻辑的视图，缺少的字段必须在源表中有default约束
insert into vtest VALUES('ps','t',1000,2000);
delete from vtest where job_id = "ps" and job_title = "t";




