pragma solidity >=0.4.22 <0.6.0;
contract gamesc{
    address public publisher;
    string public game_publisher;
    string public game_title;
    // string public game_owner_id;
    uint public game_price;
    uint public publish_time;
    uint public changeNum;
    uint public memNum;


    struct mems{
        address mem_address;
        // string mem_id;
        uint buy_time;
    }
    mapping (uint => mems) public membership;

    modifier priceEqual{
        require(msg.value == game_price* 1 ether);
        _;
    //18 x 0
    }
    modifier onlyPublisher {
        require (msg.sender ==publisher);
        _;
    }

    modifier onlyMember{
        bool qual = false;
        for (uint i=1; i <= memNum ;i++){
            if(membership[i].mem_address == msg.sender){
                qual =true;
            }
        }
        require(qual==true);
        _;
    }

    constructor(address _publisher,string memory _game_title, string memory _game_publisher, uint _game_price) public {

        publish_time = now;
        publisher = _publisher;
        game_title = _game_title;
        game_publisher = _game_publisher;
        game_price = _game_price;
        changeNum = 0;
        memNum = 1;

    }

    function registerMember(address _mem_address) public payable priceEqual{
        membership[memNum] = mems({
            mem_address : _mem_address,
            // mem_id : _mem_id,
            buy_time : now
        });
        memNum ++;

    }
    function changeAddr(address _changeAddress) public onlyMember{

        for (uint i=1; i <= memNum ;i++){

            if(membership[i].mem_address == msg.sender){
                membership[i].mem_address = _changeAddress;
                membership[i].buy_time = now ;
            }
        }
        changeNum++;
    }
    function make_payable(address x) internal pure returns(address payable){
        return address(uint160(x));
    }
    function getEther() onlyPublisher public {
        make_payable(publisher).transfer(address(this).balance);
    }
}