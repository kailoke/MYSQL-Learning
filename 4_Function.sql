# 函数
/*
一、定义：将一组逻辑语句封装在函数体中，对外暴露方法名
二、调用：SELECT 函数名(实参列表) [FROM table当实参需要用表中数据则from];
三、作用：对group by分组后的结果集进行函数调用
四、函数分类：
	> 1.单行函数	作用于一个数据得到一个返回值
	> 2.分组函数	作用于一组数据得到一个返回值	(又名统计函数 聚合函数 组函数)
五、常见函数：
	> 1.字符函数，处理字符串相关，注意length()是`字节`长度
	> 2.日期函数，获得时间/日期，获得其具体字段
			格式化(date_formate)|解析(str_to_date)
	> 3.数学函数，随机、四舍五入、取整、取模
	> 4.其他函数
*/

# 一、字符函数，MYSQL中索引从`1`开始
# 1. length(str): 获得字符串的`字节`长度
SHOW VARIABLES LIKE "%char%";
SELECT LENGTH('张三丰'); # UTF8，常见汉语3字节，不常见(较多)4字节

# 2. concat(String[] str): concatenate，拼接字符串
SELECT CONCAT(last_name," ",first_name) as 姓名 from employees;

# 3. upper() / lower(): str转换为 大 / 小写
SELECT CONCAT(UPPER(last_name)," ",LOWER(first_name)) as 姓名 from employees;

# 4. subStr(str, pos, len): 截取从pos开始长len的子串(SQL中索引从1开始)
SELECT SUBSTR("李莫愁爱上了陆展元",7) AS sub_put;
SELECT SUBSTR("李莫愁爱上了陆展元",1,3) AS sub_put;

# 5. inStr(str,substr): 返回substr在str中第一次出现的索引，找不到返回0 = 1-1
SELECT inStr("杨不悔爱上了殷六侠","殷六侠") as inStr_out;	# 7
SELECT inStr("杨不悔爱上了殷六侠","王六侠") as inStr_out;	# 0

# 6. trim(str): 去除str头尾空格
SELECT LENGTH(trim("    张翠山  1 ")) as trim_out;
# 6. trim(char FROM str): 去除str中头尾char字符
SELECT trim('a' from "aaaaa张aaa翠aaa山aa aaa") as trim_out;

# 7. lPad(str,len,padStr): 用padStr从左填充未满长度(len)，长度是字符个数
SELECT lpad("殷素素",10,"*") as lpad_out;

# 8. rPad(str,len,padStr): 用padStr从右填充未满长度(len)，长度是字符个数
SELECT rpad("殷素素",10,"*") as rpad_out;

# 9. replace(str,src,dest): 将str中的src替换为dest
SELECT REPLACE("张无忌爱周芷若周芷若周周芷若","周芷若","赵敏") as replace_out;


# 二、日期函数： 日期/时间的获取，字段获取，格式化与解析
# 1. now():系统日期 + 时间
SELECT now();
# 2. current_date(): 日期
SELECT CURRENT_DATE();
# 3. current_time(): 时间
SELECT current_time();
# 4. 获取日期/时间的指定部分:年、月、日|时、分、秒
/* 函数
	> YEAR(Date)  
	> MONTH(Date) MONTHNAME(Date):月名(英文)
	> DAY(Date) 
	> HOUR(Time) 
	> MINUTE(Time) 
	> SECOND(Time)
*/
# 5. str_to_date(str,format): 字符串按format转换成日期
/* 格式符
	> %Y 4位年份		%y 2位的年份
	> %m 01 02..		%c 1 2 3...
	> %d 01 02
	> %H 24小时制		%h 12小时制
	> %i 分钟 01 02...
	> %s 秒 01 02 ...
*/
SELECT STR_TO_DATE('1998-3-2',"%Y-%m-%d") AS 日期;

# 6. date_format(date,format): 日期按fromat格式化成字符串
SELECT date_format(now(),"%Y-%m-%d %H:") 日期;

# 案例1 查询入职日期为 1992-4-3的员工信息
SELECT * FROM employees WHERE hiredate = STR_TO_DATE("4-3-1992","%c-%d-%Y");

# 案例2 查询有奖金的员工名和入职日期
SELECT last_name,DATE_FORMAT(hiredate,"%Y年%c月%d日") AS 入职日期 FROM employees WHERE commission_pct IS NOT NULL;


# 三、数学函数
# 1. round(X): 整数四舍五入 / ROUND(X,D)：小数四舍五入，保留D位小数
SELECT round(-1.8) as round_out;
SELECT round(12.3342,2) as round_out;
# 2. ceil(X): 向上取整 按大小向上 (负数)	ceil 天花板
SELECT ceil(-1.001) as ceil_out;

# 3. floor(X)	向下取整 按大小向下 (负数)	floor 底板
SELECT floor(-9.9) as floor_out;

# 4. truncate(X,D): 截断，保留D位小数
SELECT truncate(-1.001,1) as truncate_out;

# 5. MOD(N,M): 取模，取模公式 N - (N / M) * M， N/M是整数
SELECT mod(10,3);

# 6. RAND(): 随机double = [0,1)
SELECT ROUND(rand(),4) rand_out;


# 四、其他函数
# 1. VERSION(): DBMS版本
SELECT VERSION();
# 2. DATABASE(): 当前数据库名
SELECT database();
# 3. USER(): 当前用户名@地址
SELECT user();
# 4. PASSWORD(str) 加密str(?? 不能使用？)
SELECT PASSWORD("燕小乙");
# 5. MD5(str)
SELECT MD5('阿里巴巴');

