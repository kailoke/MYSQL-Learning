# SQL数据类型
/*
一、数值型
	> 1.整型 : 
			> tinyInt 		1B
			> smallInt		2B
			> mediumInt		3B
			> int/integer 4B
			> bigInt			8B
		> 默认整型是有符号的，无符号 int unsigned (修饰后缀)
		> 插入value超出整型范围则value = 临界值  (左侧或右侧) Warning:out of range
		> 数值的长度由整型类型本身决定
		> 整型的M是最大显示宽度，zerofill 用0从左填充空位，自动转为无符号类型
			
	> 2.浮点型，省略MD，根据数值精度决定类型精度
			> float(M,D)		4B
			> double(M,D)		8B
		D: 保留小数位数，超出则四舍五入；不足则补0
		M: 长度超出后，优先保留小数位，剩余给整数位的最大值
			> float(5,2) 1234.5 ---> 999.50
			> 默认M = 0，可变长度
			
	> 3.定点型，默认 M,D = 10,0
		>dec(M,D)				decimal的简写
		>decimal(M,D)		精确度高时优先使用
			
			
二、字符型(串数据)	M:最大的`字符`数
	> 1.短文本：
		> char(M)			固定长度	tinyInt unsigned	可省略，默认1
		> varchar(M)	可变长度	samllInt unsigned	不可省略

	> 2.长文本
			> text bigText ...
	> 3.二进制		
		> blob(长二进制)
		> binary(短二进制)
		> varbinary(短二进制)	

	> 4.enum：field enum(v1,v2,...) 插入操作的值有且仅在enum中有一个，否则ull
	> 5.set：field set(v1,v2,v3,...) 插入操作的值`列表`全部属于集合可以插入，否则null
		
		
三、日期型
	> datetime	8B 日期+时间，常量值
	> timestamp 4B 时间戳，会适应时区和MySQL版本自动更新，更能反映当前系统时间
	> date			
	> time
	> year

*/