# 常见函数

/*
函数：将逻辑语句封装在方法体中，对外暴露方法名
调用：SELECT 函数名(实参列表) [FROM table];

分类：
	> 1.单行函数	CONCAT() LENGTH() IFNULL() 一参一返回值
	> 2.分组函数	一组值获得一个返回值.		统计函数、聚合函数、组函数
*/

# 一、字符函数	String类
/*
 > 1.LENGTH() 获得字节个数
 > 2.CONCAT()	concatenate，拼接字符串
 > 3.UPPER() / LOWER()	大小写转换
 > 4.SUBSTR(str FROM pos FOR len)
 > 5.INSTR(str,substr)	返回substr在str中第一次出现的索引，找不到返回0 (1-1)
 > 6.TRIM([remstr FROM] str)	去除头尾字符串remstr from str，默认空格
 > 7.LPAD(str,len,padstr)	left pad 用指定字符串padstr从左填充未满的指定长度
 > 8.RPAD(str,len,padstr) right pad 用指定字符串padstr从右填充未满的指定长度
 > 9.REPLACE(str,from_str,to_str)
*/
SELECT LENGTH('张三丰');
SHOW VARIABLES LIKE "%char%";
# SUBSTR(str,pos,len)
SELECT SUBSTR("李莫愁爱上了陆展元",7) AS out_put;
SELECT SUBSTR("李莫愁爱上了陆展元",1,3) AS out_put;



# 二、数学函数	Math类
/*
 > 1. ROUND(X)	/ ROUND(X,D)：保留D位小数
 > 2. CEIL(X)	  向上取整 按大小向上 (负数)
 > 3. FLOOR(X)	向下取整 按大小向下 (负数)
 > 4. TRUNCATE(X,D)	截断，保留D位小数
 > 5. MOD(N,M)	取余 =  N - N / M * M
 > 6. RAND()		[0,1)小数
*/


# 三、日期函数
/*
 > 1. NOW()	返回当前系统日期+时间
 > 2. CURRENT_DATE() 返回当前系统日期
 > 3. CURRENT_TIME() 返回当前系统时间
 > 4. 日期时间的指定部分 年、月、日、小时、分钟、秒
			YEAR(date)  
			MONTH(date) MONTHNAME(date):月名(英文)
			DAY(date) 
			HOUR(time) 
			MINUTE(time) 
			SECOND(time)
 > 5. STR_TO_DATE(str,format) 将字符串解析成日期
		%Y 4位年份		%y 2位的年份
		%m 01 02..		%c 1 2 3...
		%d 01 02
		%H 24小时制		%h 12小时制
		%i 分钟 01 02...
		%s 秒 01 02 ...
		SELECT STR_TO_DATE('1998-3-2',"%Y-%m-%d") AS 日期;
 > 6. DATE_FORMAT(date,format) 将日期格式化成字符串
*/

# 3.1 查询入职日期为 1992-4-3的员工信息
SELECT * FROM employees WHERE hiredate = STR_TO_DATE("4-3-1992","%c-%d-%Y");

# 3.2 查询有奖金的员工名和入职日期
SELECT last_name,DATE_FORMAT(hiredate,"%Y年%c月%d日") AS 入职日期 FROM employees WHERE commission_pct IS NOT NULL;


# 四、其他函数
/*
 > 1. VERSION()
 > 2. DATABASE()	显示当前数据库名
 > 3. USER()
 > 4. PASSWORD(str) 加密str  ?? 不能使用？
 > 5. MD5(str)
SELECT MD5('阿里巴巴');
*/