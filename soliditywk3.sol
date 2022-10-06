// SPDX-Licence-Identifier:UNLICENSED
    pragma solidity >=0.7.0 <0.9.0;

    contract walletApp {
        address payable owner = payable(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4);
        uint256 public balance;

        function sendEther() public payable{
            owner.transfer(msg.value);
        }

        function acceptEther() external payable{
            balance += msg.value;
        }

           event paid(
            uint amount,
            uint time,
            address destAddr
        );

        function pay() external payable{
            emit paid(msg.value, block.timestamp, msg.sender);
        }


        modifier onlyOwner(){
            require(msg.sender == owner, "Only owner can withdraw");
            _;
        }
    }
    
