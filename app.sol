// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract Mycontract {

address public owner;

modifier onlyowner{
        require(msg.sender==owner);
        _;
    }

mapping (address => uint) public balances;  

uint public withdrawlimit;

constructor(){

    owner=msg.sender;        //Setting the owner's address as msg.sender
    withdrawlimit=10 ether;  //Some default limit
}



 //Declaring a function to set the withdraw limit.
 //onlyowner modifier ensures that only the owner can set the withdraw limit   

function setwithdrawlimit(uint limit) public onlyowner {

    withdrawlimit= limit; 
}

function withdraw(uint amount) public payable {

    require( balances[msg.sender] >= amount ,"As insufficient funds should not lead to a transaction");
    require(amount <= withdrawlimit,"Amount should be less than or equal to the withdraw limit");
   

    balances[msg.sender] -= amount;
    payable (msg.sender).transfer(amount);



}

function deposit() public payable {
        balances[msg.sender] += msg.value;
    }




}