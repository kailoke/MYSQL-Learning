# 标识列 auto_increment约束
/*
	> 一个表 至多有 一个标识列
	> 标识列 仅能应用于 数值型字段
	> 标识列必须依附于 key (unique \ PRIMARY key \ foreign key \ other key)
*/

# 一、约束列为 标识列
alter TABLE student2 MODIFY COLUMN id int auto_increment;
DESC student2;

# 二、移除列的标识列属性
alter TABLE student2 MODIFY COLUMN id int;
DESC student2;

