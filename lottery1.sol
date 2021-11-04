pragma solidity ^0.8.1;

contract lottery{
    
    address[] participant;
    uint256 balanceContract;
    
    function registerLottery() public payable {
        uint numberOfTicket = msg.value / 10000000000000000000;
        for(uint i=0;i<numberOfTicket;i++){
            participant.push(msg.sender);   
        }
        
        balanceContract +=  msg.value;
        
        
    }
    
    function viewParticipant() public view returns(address[] memory){
        
        return participant;
        
    }
    
    function pickWinner() public view returns (address) {
        uint randomHash = uint(keccak256(abi.encodePacked(block.timestamp,block.difficulty)));
        
        uint pickedWinner = randomHash % participant.length;
        
        return participant[pickedWinner];
    } 
    
    
}