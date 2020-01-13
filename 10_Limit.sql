# 分页查询
/*
一、作用：将查询结果的最终集一段一段显示
二、语法：limit offset,size
	> offset 	起始索引：可省略 !!从0开始!!
	> size 		一次查询最大记录数量
三、使用公式
	> 分页递增：limit (pageNo.-1) * pageSize, pageSize
	> 指定范围：limit start-1,end-start+1
*/

# 1. 前5条员工信息
SELECT * FROM employees LIMIT 5;
# 2. 6 - 10
SELECT * FROM employees LIMIT 5,5;

# 3. 11-25
SELECT * FROM employees LIMIT 10,15;

# 4. 查询有奖金的员工信息，并且显示工资前10名
SELECT * FROM employees
WHERE commission_pct is not NULL
ORDER BY salary DESC
LIMIT 10;
