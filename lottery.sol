pragma solidity ^0.8.1;


contract newLottery{
  address[] participants; //list of participants addresses
  uint lotteryBalance;
  address[] pickedWinner; // index of winners in the list of participants
  address[] theWinners; // the addresses of the three winners
  address owner;
  mapping(address=>bool)admin;

  constructor(){
      owner = msg.sender; // making the comtract launcher  the owner
  }


  function enterParticipants() public payable{
    require(checkpresence()==false,"You are registered"); // If else

    uint numberofTickets = msg.value/1000000000000000000;//determining the number of tickets bought a transaction
    for (uint i=0; i<numberofTickets; i++){ //looping buying of tickets
      participants.push(msg.sender);
    }
    lotteryBalance += msg.value; //updating smart contract viewable balance

  }

  
  function checkpresence()public view returns(bool){ // function presnts multiple entry into the lottery
      bool presentStatus;
    for (uint j = 0; j < participants.length; j++) {
        if (participants[j] != msg.sender){
            presentStatus = false;
        }else{
            presentStatus =true;
        }
    }
    return presentStatus;
  }
  

  function viewParticipants() public view returns(address[] memory){ // botton to view entered participants
    return participants;
  }
  

  function totalLotteryAmount() public view returns(uint){ // botton to view the total amount entered for lottery
    return address(this).balance;
  }

  function revealWinner() public returns(address[] memory){ //function is picking three winner
    require(//admin[msg.sender] == true, 
    msg.sender == owner,
    "You are not permited to reveal winner"); //condition to make the owner the only person that can pick a winner
    //uint a;
    //for (uint i=0; i<3; i++){
        uint x = uint (sha256(abi.encodePacked(block.difficulty))); //picking the first winner
        uint Winner1 = (x%participants.length);
        theWinners.push(participants[Winner1]);
        delete participants[Winner1];
        
        uint y = uint (sha256(abi.encodePacked(block.number))); //picking the second winner
        uint Winner2 = (y%participants.length);
        theWinners.push(participants[Winner2]);
        delete participants[Winner2];
        
        uint z = uint (sha256(abi.encodePacked(block.timestamp))); //picking the third winner
        uint Winner3 = (z%participants.length);
        theWinners.push(participants[Winner3]);
        delete participants[Winner3];
        
    //}
    return theWinners;

  }
  
  //function showWinners()public view returns(address[] memory){
  //    return theWinners;
  //}

  //function sendToWinner() public payable
  function withdraw() payable public { //function sends prizes to the winners according to their winning position, and a little for the owner

    //address theWinner = participants[Winner];
    address payable winnerPayable0 = payable(theWinners[0]);
    address payable winnerPayable1 = payable(theWinners[1]);
    address payable winnerPayable2 = payable(theWinners[2]);
    uint a = address(this).balance*50/100;
    uint b = address(this).balance*30/100;
    uint c = address(this).balance*15/100;
    uint d = address(this).balance*5/100;
    address payable e = payable (owner);
    
    winnerPayable0.transfer(a);
    winnerPayable1.transfer(b);
    winnerPayable2.transfer(c);
    e.transfer(d);
  }

  

}


contract lottery{
  address[] participants;
  uint lotteryBalance;
  address pickedWinner;
  uint Winner;
  mapping(address=>bool)admin;

  constructor(){
    admin[0xaE7B46e8a96F36190cc9B35C6A8c103464f098dF]=true;
  }


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

  function revealWinner() public returns(address ){
    require(admin[msg.sender] == true, "You are not permited to reveal winner");
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
