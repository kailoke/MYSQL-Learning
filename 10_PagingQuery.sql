# 分页查询
/*
	分页提交SQL请求获得分页数据
	LIMIT OFFSET,SIZE;
	> offset 	起始索引：可省略 !!从0开始!!
	> size 		分页总数量
	
	--:> LIMIT (page-1)*size,size;
*/

# 案例1. 查询前5条员工信息
SELECT * FROM employees LIMIT 5;
SELECT * FROM employees LIMIT 5,5;

# 案例2. 查询11-25条		11-1, 25-11+1
SELECT * FROM employees LIMIT 10,15;

# 案例3. 查询有奖金的员工信息，并且显示工资前10名
SELECT * FROM employees
WHERE commission_pct is not NULL
ORDER BY salary DESC
LIMIT 10;
