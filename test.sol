pragma solidity ^0.8.0;

contract addressExample{
    address public myAddress;
    
    function setAddress(address _myAddress) public {
        myAddress = _myAddress;
    }
    
    function getBalance() public view returns(uint){
        return myAddress.balance;
    }
}