---
layout: 	coco
title: 		"程序结构"
date: 		2018-08-04 12:00:00
author: 	"shamphone"
chapter:	"3"
---

## 一、合约的定义


在 Solidity 中，合约类似于面向对象编程语言中的类，他是solidity的核心概念。 
继续上一章的例子，丰富一些内容。 

```bash

pragma solidity ^0.4.0;

import "remix_tests.sol"; // this import is automatically injected by Remix.

contract Calculator {
	uint public seed = 0;
	
	constructor() public {
		seed = block.timestamp; 
	}
	function random() public  returns(uint p) {
		uint next = seed * 1103515245 ;
		next +=12345;
		next = (next/65535)%2048;
		seed = next;
		return seed;
	}
    function multiply(uint a, uint b) public pure returns(uint c)   { 
        return a * b;         
    } 
}
```

这个例子很简单， 但所有的合约代码都是这种结构。 分为三部分：

1. pragma 预编译选项申明，定义支持的浏览器版本。 
2. import 导入文件。将合约的实现按照某种逻辑来拆分，放到多个文件中，通过import来引入所依赖的其他文件。  
3. contract 合约定义，这是文件的主体内容了。  

## 二、名称

Solidity 中函数、变量、常量、类型和包的名称都遵循一个简单的原则：名称以字符(Unicode字符即可)或者下划线开始，后面可以跟任意数量的字符、数字和下划线，并且是区分大小写的。 

Solidity中有如下18个关键字，是不能用作名称：

abstract, after, case, catch, default, final, in, inline, let, match, null, of, relocatable, static, switch, try, type, typeof

另外还有一些内置的常量、类型和函数： 

- 常量：true false null 
- 类型： 	
		int int8 int16 int24 ... int256 (以8为步长递增)  
		uint uint8 uint16 uint24... uint256 (以8为步长递增)  
		fixed fixedMxN(M：8~256，以8为步长递增，N 为0~80之间的整数)  
		ufixed ufixedMxN(M：8~256，以8为步长递增，N 为0~80之间的整数)  
		bytes bytes1, bytes2... bytes32  
		string  
- 函数: function  

这些名称并不是预留的，可以在声明中使用它们，有些地方还可以覆盖重新声明，但这容易引起冲突。 
在命名风格上， 一般采用类似java的驼峰规则，而不是下划线连接。 




