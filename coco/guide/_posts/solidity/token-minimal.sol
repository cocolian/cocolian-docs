pragma solidity ^0.4.20;

contract MyToken {
    /* Map对象用来记录账户的余额， key是账户地址，value是余额 */
    mapping (address => uint256) public balanceOf;

    /* 构造函数，执行初始化操作，给虚币发行人，即默认为当前代码的发布人，设置一定的初始虚币数量。 */
    function MyToken(
        uint256 initialSupply
        ) public {
        balanceOf[msg.sender] = initialSupply;              // 初始虚币数据全部授予发行者
    }

    /* 转账 */
    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(balanceOf[msg.sender] >= _value);           // 检查发送者的账户的余额是否足够
        require(balanceOf[_to] + _value >= balanceOf[_to]); // 确认接受者的账户余额不会溢出。严谨！
        balanceOf[msg.sender] -= _value;                    // 扣减发送者的余额
        balanceOf[_to] += _value;                           // 增加接受者的余额
        return true;
    }
}
