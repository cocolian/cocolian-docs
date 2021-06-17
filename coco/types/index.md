---
layout: 	coco
title: 		"数据类型"
date: 		2018-06-10 12:00:00
author: 	"凤凰牌老熊"
chapter:	"2"
---  

从示例开始学习：

```

pragma solidity 0.4.24; 


/*

Solidity中数据类型分为值类型和引用类型。值类型是指在使用时直接传递的值，比如在函数调用时，作为参数，是复制过来使用的。 

*/
contract generalValueTypesContract {

	// 无符号整数
    uint x;

    //初始化无符号整数值为88；
    uint x = 88;

    // 整数， 初始化为78
    int a = 78; 

    // 常量，定义之后，不能再重新赋值了。  
    int constant variable1 = 8;

	// 常量
    int256 constant variable2 = 8; 

    // 对于整数，也可以使用16进制常数来初始化。 
    uint constant VERSION_ID = 0x123A1; 


    // 整数可以指定位数。 
    uint8 b;
    int64 c;
    uint248 e;

    // 类型转换
    int x = int(b);

    // 布尔类型变量
    bool b = true; 

    // solidity会自动推断这个变量类型是布尔。 
     var a = true;

    // 地址是以太坊所特有的，  20 byte/160 bit 
    address public owner;

    // 字节数组，也可以定义1~32的长度。     
    byte a; // byte is same as bytes1
    bytes2 b;
    bytes32 c;

    // 动态长度的字节数组，同byte[]    
    bytes m; 

    // 同bytes字节数组，但无法读取长度，也不能通过[]来访问指定序号的字节。字符串都是UTF-8格式，使用双引号来赋值，不能用单引号。 
    string n = "hello"; 

    // 长度为5的静态数组
    bytes32[5] nicknames; 

    // 不定长度的动态数组。 
    bytes32[] names; 

    // 使用push操作添加新的元素到数组中，返回新元素在数组中的位置。 
    uint newLength = names.push("John"); 

    // 定义字典类型的数组。比如这里定义一个字符串到整数的映射。 当然，value也可以是一个map。
    mapping (string => uint) public balances;


	//定义一个枚举类型；
    enum State { Created, Locked, Inactive }; 

    //枚举类型的变量。 
    State public state; 

    // 初始化枚举类型
    state = State.Created;

    // 枚举可以直接转换成整型。 
    uint createdState = uint(State.Locked); 


}

```

## 三、基本数据类型

Solidity 是一种静态类型语言，这意味着每个变量（状态变量和局部变量）都需要在编译时指定变量的类型。
此外Solidity还引入了最新Java规范中的var关键字来支持类型推断。


