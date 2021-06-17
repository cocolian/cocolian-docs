---
layout: 	coco
title: 		"错误处理"
date: 		2018-06-09 12:00:00
author: 	"shamphone"
status: 	"hidden"  
chapter:	"1"

---


错误处理：Assert, Require, Revert and Exceptions
======================================================

Solidity 使用状态恢复异常来处理错误。这种异常将撤消对当前调用（及其所有子调用）中的状态所做的所有更改，并且还向调用者标记错误。
便利函数 ``assert`` 和 ``require`` 可用于检查条件并在条件不满足时抛出异常。``assert`` 函数只能用于测试内部错误，并检查非变量。
``require`` 函数用于确认条件有效性，例如输入变量，或合约状态变量是否满足条件，或验证外部合约调用返回的值。
如果使用得当，分析工具可以评估你的合约，并标示出那些会使 ``assert`` 失败的条件和函数调用。
正常工作的代码不会导致一个 assert 语句的失败；如果这发生了，那就说明出现了一个需要你修复的 bug。


还有另外两种触发异常的方法：``revert`` 函数可以用来标记错误并恢复当前的调用。
``revert`` 调用中包含有关错误的详细信息是可能的，这个消息会被返回给调用者。已经不推荐的关键字 ``throw`` 也可以用来替代 ``revert()`` （但无法返回错误消息）。


.. note::
    从 0.4.13 版本开始，``throw`` 这个关键字被弃用，并且将来会被逐渐淘汰。

当子调用发生异常时，它们会自动“冒泡”（即重新抛出异常）。这个规则的例外是 ``send`` 和低级函数 ``call`` ， ``delegatecall`` 和 ``callcode`` --如果这些函数发生异常，将返回 false ，而不是“冒泡”。


.. warning::
    作为 EVM 设计的一部分，如果被调用合约帐户不存在，则低级函数 ``call`` ， ``delegatecall`` 和 ``callcode`` 将返回 success。因此如果需要使用低级函数时，必须在调用之前检查被调用合约是否存在。
	
异常捕获还未实现

在下例中，你可以看到如何轻松使用``require``检查输入条件以及如何使用``assert``检查内部错误，注意，你可以给 ``require`` 提供一个消息字符串，而 ``assert`` 不行。

::

    pragma solidity ^0.4.22;

    contract Sharer {
        function sendHalf(address addr) public payable returns (uint balance) {
            require(msg.value % 2 == 0, "Even value required.");
            uint balanceBeforeTransfer = this.balance;
            addr.transfer(msg.value / 2);
			//由于转移函数在失败时抛出异常并且不能在这里回调，因此我们应该没有办法仍然有一半的钱。
            assert(this.balance == balanceBeforeTransfer - msg.value / 2);
            return this.balance;
        }
    }

下列情况将会产生一个 ``assert`` 式异常：

#. 如果你访问数组的索引太大或为负数（例如 ``x[i]`` 其中 ``i >= x.length`` 或 ``i < 0``）。
#. 如果你访问固定长度 ``bytesN`` 的索引太大或为负数。
#. 如果你用零当除数做除法或模运算（例如 ``5 / 0`` 或 ``23 % 0`` ）。
#. 如果你移位负数位。
#. 如果你将一个太大或负数值转换为一个枚举类型。
#. 如果你调用内部函数类型的零初始化变量。
#. 如果你调用 ``assert`` 的参数（表达式）最终结算为 false。



下列情况将会产生一个 ``require`` 式异常：


#. 调用 ``throw`` 。
#. 如果你调用 ``require`` 的参数（表达式）最终结算为 ``false`` 。
#. 如果你通过消息调用调用某个函数，但该函数没有正确结束（它耗尽了 gas，没有匹配函数，或者本身抛出一个异常），上述函数不包括低级别的操作 ``call`` ， ``send`` ， ``delegatecall`` 或者 ``callcode`` 。低级操作不会抛出异常，而通过返回 ``false`` 来指示失败。
#. 如果你使用 ``new`` 关键字创建合约，但合约没有正确创建（请参阅上条有关”未正确完成“的定义）。
#. 如果你对不包含代码的合约执行外部函数调用。
#. 如果你的合约通过一个没有 ``payable`` 修饰符的公有函数（包括构造函数和 fallback 函数）接收 Ether。
#. 如果你的合约通过公有 getter 函数接收 Ether 。
#. 如果 ``.transfer()`` 失败。


在内部， Solidity 对一个 ``require`` 式的异常执行回退操作（指令 ``0xfd`` ）并执行一个无效操作（指令 ``0xfe`` ）来引发 ``assert`` 式异常。
在这两种情况下，都会导致 EVM 回退对状态所做的所有更改。回退的原因是不能继续安全地执行，因为没有实现预期的效果。
因为我们想保留交易的原子性，所以最安全的做法是回退所有更改并使整个交易（或至少是调用）不产生效果。
请注意， ``assert`` 式异常消耗了所有可用的调用 gas ，而从 Metropolis 版本起 ``require`` 式的异常不会消耗任何 gas。

下边的例子展示了如何在 revert 和 require 中使用错误字符串：

::

    pragma solidity ^0.4.22;

    contract VendingMachine {
        function buy(uint amount) payable {
            if (amount > msg.value / 2 ether)
                revert("Not enough Ether provided.");
            // 下边是等价的方法来做同样的检查：
            require(
                amount <= msg.value / 2 ether,
                "Not enough Ether provided."
            );
            // 执行购买操作
        }
    }

这里提供的字符串应该是经过 :ref:`ABI 编码 <ABI>` 之后的，因为它实际上是调用了 ``Error(string)`` 函数。在上边的例子里，``revert("Not enough Ether provided.");`` 会产生如下的十六进制错误返回值： 

.. code::

    0x08c379a0                                                         // Error(string) 的函数选择器
    0x0000000000000000000000000000000000000000000000000000000000000020 // 数据的偏移量（32）
    0x000000000000000000000000000000000000000000000000000000000000001a // 字符串长度（26）
    0x4e6f7420656e6f7567682045746865722070726f76696465642e000000000000 // 字符串数据（"Not enough Ether provided." 的 ASCII 编码，26字节）

