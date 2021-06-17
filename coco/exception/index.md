---
layout: 	coco
title: 		"异常处理[未开始]"
subtitle: 	"区块链相关"
date: 		2018-06-10 12:00:00
author: 	"凤凰牌老熊"
chapter:	"6"
---  

```
pragma solidity 0.4.8;

    /*
    * @title A Simple Example
    * @author Toshendra Sharma
    * @notice Example for the Solidity Course
    * 
    */

// There are some cases where exceptions are thrown automatically. 
// Otherwise You can use the throw instruction to throw an exception manually. 
// The effect of an exception is that the currently executing call is 
// stopped and reverted. It means all changes to the state and balances are undone 
// and the exception is also “bubbled up” through Solidity function calls 
// when exceptions are send all the low-level functions call, delegate calls and call code, 
// will return false.

// It is interesting to note that Catching exceptions is not yet possible.

// Lets see an example, to know how a throw can be used to easily revert 
// an Ether transfer and also how to check the return value of send. 

contract Sharer {
    function sendHalf(address addr) payable returns (uint balance) {
        if (!addr.send(msg.value / 2)) // send half of the ether to the addr mentioned in the call.
            throw; // here throw is a User Generated Exception and it also reverts the transfer to Sharer
            
            // assert(condition) can also generate a User Exception  
        return this.balance;
    }
}

  

// Currently, Solidity automatically generates a runtime exception in the following situations:

// If you access an array at a too large or negative index (i.e. x[i] where i >= x.length or i < 0).

// If you access a fixed-length bytesN at a too large or negative index.

// If you call a function via a message call but it does not finish properly 
// (i.e. it runs out of gas, has no matching function, or throws an exception itself), 
// except when a low level operation call, send, delegatecall or callcode is used. 
// The low level operations never throw exceptions but indicate failures by returning false.

// If you create a contract using the new keyword but the contract creation does not 
// finish properly (see above for the definition of “not finish properly”).

// If you divide or modulo by zero (e.g. 5 / 0 or 23 % 0).

// If you shift by a negative amount.

// If you convert a value too big or negative into an enum type.

// If you perform an external function call targeting a contract that contains no code.

// If your contract receives Ether via a public function without payable modifier 
// (including the constructor and the fallback function).

// If your contract receives Ether via a public getter function.

// If you call a zero-initialized variable of internal function type.

// If a .transfer() fails.

```  