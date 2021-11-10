pragma solidity ^0.8.1;

contract voting{
    address[] votingItems;
    uint[] item1;
    uint[] item2; 
    
    function addMoney() public payable{}
    
    function companyAddresses(address _companyAddresses) public{
        votingItems.push(_companyAddresses);
    }
    
    function enterItems(uint _item) public{
        if (_item == 1){
            item1.push(_item);
            
        }
        if (_item == 2){
            item2.push(_item);
        }
    }
    
    
    function countVotes() public returns(address){
        
        address payable winnerPayable0 = payable(votingItems[0]);
        address payable winnerPayable1 = payable(votingItems[1]);
        
        address winner;
        
        if (item1.length < item2.length){
            winner = votingItems[0]; 
            winnerPayable0.transfer(address(this).balance);
        }else{winnerPayable1.transfer(address(this).balance);
            winner = votingItems[1];
            
        }
        
        return winner;
    }
}

pragma solidity ^0.8.1;

contract votingAllwin {
    struct Voter {
        uint urutan;
        string nama;
        uint weight; // weight is accumulated by delegation
        bool voted;  // if true, that person already voted
        uint vote;  // index of the voted proposal
        bool admin;
    }
    
    struct Proposal {
        string name;   // short name (up to 32 bytes)
        uint voteCount; // number of accumulated votes
    }
    
    struct Winner {
        string name;
        uint voteCount;
    }
    Winner winnerz;
    
    uint _urutanvoter;
    uint _urutanproposal;
    mapping(address => Voter) public voters;
    mapping(uint => Proposal) public proposals;
    //mapping(uint => Winner) public winners;
    
    
    
    function Making_Admin(string memory _address) public {
        
    }
    
    function Voter_Register(string memory _nama) public {
        string memory nama = _nama;
        uint _urutan; 
         for(uint i=0; i<1; i++){
            voters[msg.sender].nama = nama;
            voters[msg.sender].weight = 1;
            voters[msg.sender].voted = false;
            voters[msg.sender].vote = 0;
            voters[msg.sender].urutan = _urutan;
            voters[msg.sender].admin = false;
            _urutan++;
        }
    }
    
    function Proposal_Register(string memory _namaitem) public {
        string memory namaitem = _namaitem;
         for(uint i=0; i<1; i++){
            proposals[_urutanproposal].name = namaitem;
            proposals[_urutanproposal].voteCount = 0;
            _urutanproposal++;
        }
    }
    
    function Choose(uint _pilihan) public {
        require (voters[msg.sender].voted == false, "Already Vote");
        require (_pilihan < _urutanproposal, "That choice is not available");
        
        proposals[_pilihan].voteCount = proposals[_pilihan].voteCount + 1;
        voters[msg.sender].voted = true;
        voters[msg.sender].vote = _pilihan;
    }
    
    function Winner_Declare() public returns (string memory){
        winnerz.name = "";
        winnerz.voteCount = 0;
        for (uint i=0; i<_urutanproposal; i++){
            if (winnerz.voteCount <= proposals[i].voteCount) {
                winnerz.name = proposals[i].name;
            }
        }
        return (winnerz.name);
    }
}


contract votingRevin{
    
    struct itemDetails{
        string itemName;
        uint itemNumber;
        uint votenumber;
        bool votingStatus;
    }
    
    mapping(address=>bool) initiator;
    mapping(string=>itemDetails) public itemList;
    uint numberOfItem;
    string winner;
    uint maxWinner;
    
    string[] itemListShow;
    
    constructor(){
        initiator[msg.sender] = true;
    }
    
    
    function addVotingItem(string memory item) public{
        numberOfItem +=1;
        itemList[item].itemName = item;
        itemList[item].itemNumber = numberOfItem;
        itemList[item].votingStatus = true;
        
        itemListShow.push(item);
    }
    
    function vote(string memory item) public{
        require(itemList[item].votingStatus == true,"The Voting has been closed");
        itemList[item].votenumber += 1;
        
        
        
    }
    
    function showItem() public view returns(string[] memory){
        return itemListShow;
    }
    
    function closeVoting() public returns(string memory){
        uint maxVotes;
        for(uint i=0;i<itemListShow.length;i++){
            itemList[itemListShow[i]].votingStatus = false;
            
            if(maxVotes <= itemList[itemListShow[i]].votenumber){
                winner = itemList[itemListShow[i]].itemName;
                maxVotes = itemList[itemListShow[i]].votenumber;
            } else{
                winner = winner;
                maxVotes = maxVotes;
            }
        }
        return winner;
         
    }
    
}

contract votingRashid{
    
    //food List
    uint public dakgalbi;
    uint public gobchang;
    uint public makchang;
        //bool isVote;
    
    
    //beverage list
    uint public avocado_juice;
    uint public lemonade;
    uint public tea;
        //bool isVote;
    
    
    struct Voter{
        //address alamat;
        bool isFood;
        bool isBeverage;
    }
    mapping (address => Voter) public selectFood;
    //mapping (address => beverage) public selectDrinks;
    
    address public admin;
    
    constructor(){
        admin = msg.sender;
    }
    
    function chooseFood(uint8 idx) public{
        require (selectFood[msg.sender].isFood == false,"Anda sudah tidak bisa vote");
        require (idx <=2, "Hanya ada 3 menu!");
        selectFood[msg.sender].isFood = true;
        if (idx == 0){
           dakgalbi++; 
        }
        else if(idx == 1){
            gobchang++;
        }
        else if (idx ==2){
            makchang++;
        }
    } 
    
    function chooseBeverage(uint8 idx) public{
        require (selectFood[msg.sender].isBeverage == false,"Anda sudah tidak bisa vote");
        require (idx <=2, "Hanya ada 3 menu!");
        selectFood[msg.sender].isBeverage = true;
        if (idx == 0){
           avocado_juice++; 
        }
        else if(idx == 1){
            lemonade++;
        }
        else if (idx ==2){
            tea++;
        }
        
    } 
}