---
layout: 	coco
title: 		"函数定义"
date: 		2018-04-01 12:00:00
author: 	"shamphone"
chapter:	"1"

---

函数在所有的语言中都是一种常见类型。Solidity中的函数关键字是function，我们先来看一个最简单的例子：



## 一、函数的参数  

函数的入参定义与变量类似。我们可以省略未使用到的参数变量名，如下例所示：

```
pragma solidity ^0.4.24;

contract FunctionExample {
    //函数的入参如变量的定义方式
    //未使用的参数可以省略变量名
    function InputPara(uint a, uint) {
       a = a + 1;
    }
}
```

例子中我们按变量定义的方式定义了``uint a``。由于我们在函数中未使用到第二个参数，省略了第二个参数的变量名。


## 二、函数的返回值  

返回值的定义与参数类似，跟在``returns``关键字后即可。

```
pragma solidity ^0.4.24;

contract FunctionExample {
    //定义了一个返回值变量`r`
    function outputParameter(uint a, uint b) returns (uint r){
       r = a + b;
    }
}
```

上例中，我们定义了一个返回值变量``uint r``，并在函数内让``r = a + b;``，从而返回了结果。

## 三、 return关键字

我们还可以使用``return``关键字来指定返回的值，使用``return``时，我们不会用到返回值的变量名称，可以省略。

```
pragma solidity ^0.4.0;

contract FunctionExample {
    
    //使用`return`关键字指定返回值
    function output1(uint a, uint b) returns (uint r){
        return a + b;
    }
    
    //省略返回参数的变量名定义
    function output2(uint a, uint b) returns (uint){
        return a + b;
    }
    
    /*
    function output3(uint a, uint b) returns (uint x, uint mul){
        x = a + b;
        mul = a * b;
        //不能混合使用两种定义方式
        //使用`return`时要返回所有定义
        //Untitled3:18:9: Error: Different number of arguments in return statement than in returns declaration.
        return x;
    }
    */
    
    function output4(uint a, uint b) returns (uint mul){
        mul = a * b;
        //不能混合使用两种定义方式
        //使用`return`时要返回所有定义
        //Untitled3:18:9: Error: Different number of arguments in return statement than in returns declaration.
        return 1;//1
    }
}

```

我们在output1()中使用了return关键字来指定要返回的值；在output2()中我们省略了返回参数的变量名定义；一旦使用了return的定义方式，我们要保证return返回的参数数量要与定义匹配，如output3()所示。从output4()中我们可以看出来，如果同时使用return关键字和变量定义方式，以return为准。

## 四、返回多个值

Solidity语言支持在一个函数中返回多个结果。使用``return (v0, v1, ... vn);``来返回多个值。

```

contract FunctionExample {
    //返回多个值
    function returnMul(uint a) returns (uint, uint){
        return (a, a + 1);
    }
}
```
上述函数返回了原值，和原值加一后的新值两个结果。

## 五、杂项  

返回参数会被初始化为0，如果没有被明确的设置值，那么它会一直保持零。

函数的参数和返回值可以在函数体内被用作表达式的一部分。当然他们也可被赋值，由于基本类型是值传递，所以即使变量被修改为新值，也不会影响函数外的调用原值。

```

contract ByValue {
    
    function foo(uint a) public pure  returns (uint){
        //修改传入的参数变量，并返回
        a = a + 1;
        return a;
    }
    
    function bar() public pure returns (uint, uint){
        uint i = 1;
        //传入的参数`i`并没有被改变
        uint j = foo(i);
        return (i, j);//返回值(1,2)
    }
}

```
我们看到在调用``foo()``时传入了``i``，并在函数内修改了它的值；但函数``foo()``函数调用完成后，``i``仍为``1``。

```
contract ByRef {  
    
    function foo(uint[] b) public pure returns (uint){
        //修改传入的参数变量，并返回
        b[0] = b[0] + 1;
        return b[0];
    }
    
    function bar() public pure returns (uint, uint){
		uint[] memory a = new uint[](1);
		a[0] = 1;
        uint j = foo(a);
        return (a[0], j);//返回值(2,2)
    }
}
```
数组是按引用传递，这样在foo中会对数组元素中的值做修改，最后返回值都是修改后的值。 map也是类似的情况。 
