# 常见数据类型
/*
 > 数值型
		> 整型 : TINYINT,SMALLINT,MEDIUMINT,INT/INTEGER,BIGINT
			> 符号： 默认有符号， INT unsigned
			> 插入数值超出整型范围则 = 临界值  (左侧或右侧) out of range
			> 整型的大小由类型决定
			> M : 默认11
			> zerofill 用0从左填充空位
			
		> 浮点数
			> float(M,D)		
			> double(M,D)		
			D: 保留小数位数，四舍五入 或 补0
			M: 优先小数位后，剩余给整数位
			  > 默认M = 0，可变长度
			
		> 定点数
			>dec(M,D)				一直
			>decimal(M,D)		精度
			默认 M,D = 10,0
	
 > 字符型
		M: 字符数
		> char			固定长度	默认1
		> VARCHAR		可变长度	不可省略
		
		> text
		
		> binary(短二进制)
		> varbinary(短二进制)
		> blob(长二进制)
		
		> enum('','','')  值 等于 任意枚举对象即可插入，否则为空
		> set('','','')		值 从属于 集合列表 都可以插入，否则为空
		
		
 > 日期型
		> date
		> datetime
		> timestamp
		> time
		> year

*/