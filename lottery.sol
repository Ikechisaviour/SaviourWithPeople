pragma solidity ^0.8.1;

contract lottery{
  address[] participants;
  uint lotteryBalance;
  address pickedWinner;
  uint Winner;


  function enterParticipants() public payable{
    uint numberofTickets = msg.value/1000000000000000000;//determining the number of tickets bought a transaction
    for (uint i=0; i<numberofTickets; i++){
      participants.push(msg.sender);
    }
    lotteryBalance += msg.value;

  }

  function viewParticipants() public view returns(address[] memory){
    return participants;
  }

  function totalLotteryAmount() public view returns(uint){
    return address(this).balance;
  }

  function revealWinner() public payable returns(address){
    uint a = uint (sha256(abi.encodePacked(block.difficulty)));
    Winner = (a%participants.length);
    return participants[a%participants.length];
    

  }

  //function sendToWinner() public payable
  function withdraw() payable public {

    address theWinner = participants[Winner];
    address payable winnerPayable = payable(theWinner);
    winnerPayable.transfer(address(this).balance);
  }

  

}
