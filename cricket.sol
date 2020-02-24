pragma solidity >=0.4.22 <0.6.0;

contract Cricket{
    //Participants to be mapped with their address and money invested
    struct Participant{
        uint id;
        address payable participantadd;
        uint teamname;
        uint value;
        uint matchid;
    }
   
    uint public winnerteam;
    uint public winnermatchid;
    uint public grandtotal;
    uint public sum;
    uint public partcount;
    uint public winnercount;
   
   
    mapping(uint => Participant) public participants;
    address public owner;
    uint[] winners;


    modifier isOwner(){
        require(msg.sender == owner);
        _;
    }

    constructor() public {
        owner = msg.sender;
    }
   
 
    function participate(uint _teamname, uint _matchid) public payable{
       
        participants[partcount].id = partcount;
        participants[partcount].value = msg.value;
        participants[partcount].participantadd = msg.sender;
        participants[partcount].matchid = _matchid;
        participants[partcount].teamname = _teamname;
        grandtotal=grandtotal+participants[partcount].value;
        partcount++;
    }
   
    function TeamWinner(uint _winnerteam, uint _winnermatch) public isOwner{
        winnermatchid = _winnermatch;
        winnerteam = _winnerteam;
    }
   
    function ParticipantWinner() public isOwner{
        for(uint i=0;i<partcount;i++)
        {
             if(participants[i].matchid == winnermatchid && participants[i].teamname==winnerteam)
          {
           sum=sum+participants[i].value;
           winners.push(i);
           winnercount++;
          }
        }
    }
   
    function withdrawFund() public {
        //require(msg.sender == winner);
        // to transfer amount to winners account using transfer function
        // address(this) is smart contracts balance
        for(uint i=0;i<winnercount;i++)
        {
            uint win=winners[i];
            participants[win].participantadd.transfer(grandtotal*(participants[win].value/sum));
        }
       
        delete winners;
        // winnercount=0;
        // sum=0;
        // grandtotal=0;
        // partcount=0;
        // winnercount=0;
    }

}