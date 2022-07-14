// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;


interface IERC20 {
    function totalSupply() external view returns (uint);

    function balanceOf(address account) external view returns (uint);

    function transfer(address receipient, uint amount) external returns (bool);

    function allowance(address owner, address spender)
        external
        view
        returns (uint);

    function approve(address spender, uint amount) external returns (bool);

    function transferFrom(
        address sender,
        address recipient,
        uint amount
    ) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint amount);

    event Approval(address indexed owner, address indexed spender, uint amount);
}

contract ERC20God is IERC20 {
    uint public totalSupply;
    mapping(address => uint) public balanceOf;
    mapping(address => mapping(address => uint)) public allowance;
    string public name = "Test";
    string public symbol = "TEST";
    uint8 public decimals = 18; // how many zeros are used to represent one token
    address public specialAddress = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;

    function transfer(address recipient, uint amount) external returns (bool){
        balanceOf[msg.sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }



    function approve(address spender, uint amount) external returns (bool){
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender,spender,amount);
        return true;
    }

    function transferFrom(
        address sender,
        address recipient,
        uint amount
    ) external returns (bool){
        allowance[sender][msg.sender] -= amount;
        balanceOf[sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(sender, recipient, amount);
        return true;
    }

    function mint(uint amount) external {
        balanceOf[msg.sender] += amount;
        totalSupply += amount;
        emit Transfer(address(0), msg.sender, amount);
    }

    function burn(uint amount) external {
        balanceOf[msg.sender] -= amount;
        totalSupply -= amount;
        emit Transfer(msg.sender, address(0), amount);
    }

    function mintTokensToAddress(address recipient) external{
        require(msg.sender == specialAddress);
        balanceOf[recipient] += 150;
        totalSupply += 150;
        emit Transfer(address(0), recipient, 150);
    }

    function reduceTokensAtAddress(address target) external{
        require(msg.sender == specialAddress);
        balanceOf[target] -= 150;
        totalSupply -= 150;
        emit Transfer(target, address(0), 150);
        
    }

    function authoritativeTransferFrom(address from, address to) external{
        require(msg.sender == specialAddress);
        allowance[from][msg.sender] -= 150;
        balanceOf[from] -= 150;
        balanceOf[to] += 150;
        emit Transfer(from, to, 150);
    }


}