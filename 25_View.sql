# 视图
/*
一、视图：临时虚拟表，和普通标一样使用
			> mysql5.1 新增特性，通过表动态生成的数据
二、保存sql逻辑，不保存查询结果，每次调用时动态生成视图
三、作用：
	> sql语句重用
	> 减少sql语句嵌套，提供可阅读性，步骤拆分
	> 保护源数据，仅提供必要性，从而提高数据安全性
*/

# 一、创建视图
# CREATE VIEW 视图名 AS ...

# 案例1.1 查询有邮箱中包含 a 字符的员工名、部门名和工种信息
CREATE OR REPLACE view v1 AS
SELECT last_name,email,department_name,job_title
FROM employees e INNER JOIN departments d ON e.department_id = d.department_id
INNER JOIN jobs j ON e.job_id = j.job_id;

SELECT * FROM v1 WHERE email LIKE "%a%";

# 二、修改视图
# 替换 ：creat or replace view 别名 as ...
# 修改 : alter view v1 as ...
# 删除 : drop view 视图1，视图2，...
# 结构 : desc v1;
# 代码 : show create view v1;

# 不能插入连接表
INSERT into v1(last_name,department_name,job_title) values ("a",'a','a');

create or replace view vtest AS
SELECT * FROM jobs;
# 插入非连接表数据，缺少的字段必须有default值
INSERT into vtest VALUES('ps','t',1000,2000);
