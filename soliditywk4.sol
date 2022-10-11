// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.7.0 <0.9.0;

contract walletApp {
  address public owner;
  mapping (address => uint) public balances;

// events 
  event store(
    uint amount,
    uint timestamp,
    address sender
  );

  event withdraw(
    uint amount,
    uint timestamp,
    address sender
  );

   event sendEther(
    uint amount,
    uint timestamp,
    address sender,
    address receiver
  );


// modifier
  modifier onlyOwner(){
    require(msg.sender == owner,"Only owner can withdraw");
    _;
  }

  modifier onlyUser(uint: amount){
    require(amount<= balances[msg.sender], "Insufficient fund");
    _;
  }

  constructor(){
    owner = msg.sender;
  }

  // stores ether
    receive() payable external{
    balances[msg.sender] += msg.value;
    emit store(block.timestamp, msg.sender, msg.value);
  }

  // receives ether
  function withdraw(uint amount) onlyUser(amount) external {
    balances[msg.sender] -= amount;
    payable(msg.sender).transfer(amount);
    emit withdraw(block.timestamp, msg.sender, amount);
  }

  // sends ether
   function sendEther(uint amount, address receiver) onlyUser(amount) external {
    balances[msg.sender] -= amount;
    balances[receiver] += amount;
    emit sendEther(block.timestamp, msg.sender, receiver,  amount);
  }
}
