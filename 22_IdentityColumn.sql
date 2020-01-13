# 标识列 auto_increment
/*
	> 一个表 至多有 一个标识列
	> 标识列 仅能应用于 数值型字段
	> 标识列必须依附于 key (PRIMARY key\ unique \ foreign key \ other key)
	
*/

# 2 修改标识列为 自增列
ALTER TABLE student2 MODIFY COLUMN id int auto_increment;
DESC student2;
# 3 删除标识列 自增属性
ALTER TABLE student2 MODIFY COLUMN id int;
DESC student2;

SHOW CREATE TABLE jobs;