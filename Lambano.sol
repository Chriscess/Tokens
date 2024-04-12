// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;


contract Lambano {

    address public owner;

    string private name = "Christine";
    string private symbol = "cht";
    uint private decimal = 6;
    
    uint private totalSupply_;

    mapping (address => uint) private balances;

    constructor(){
        owner = msg.sender;
    }

    function totalSupply() public view returns (uint){
        return totalSupply_;
    }

    function balanceOf(address addr) public view returns (uint){
        return balances[addr];
    }

    function transfer(address to, uint amount) public returns (bool){
        if (balances[msg.sender] < (amount * (10 ** decimal))) revert("Insufficient amount");
        balances[msg.sender] = balances[msg.sender] - (amount * (10 ** decimal));
        balances[to] = balances[to] + (amount * (10 ** decimal));
        return true;
    }

    function mint(uint amount) public {
        require(msg.sender == owner, "You are not the Owner");
        totalSupply_ = amount * (10 ** decimal);
        balances[owner] += (balances[owner] + (amount * (10 ** decimal)));
}

    function burn(uint amount) public  {
        if (balances[msg.sender] < (amount * (10 ** decimal))) revert("Not enough balance");
        balances[msg.sender] = balances[msg.sender] - (amount * (10 ** decimal));
        totalSupply_ = totalSupply_ - (amount * (10 ** decimal));
    }
}






