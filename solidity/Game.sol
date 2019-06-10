pragma solidity >=0.4.22 <0.6.0;
contract gamesc{
    address public publisher;
    address public buyer;
    address public seller;
    string public game_publisher;
    string public game_title;
    // string public game_owner_id;
    uint public game_price;
    uint public sell_price;
    uint public publish_time;
    uint public changeNum;
    uint public memNum;
    uint public sellNum;


    struct mems{
        address mem_address;
        // string mem_id;
        uint buy_time;
    }
    
    struct sales{
        address sale_mem_address;
        uint sell_price;
        uint sell_time;
    }
    mapping (uint => mems) public membership;
    mapping (uint => sales) public sale_list;
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
        sellNum = 0;

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
    
    
    
    
    function sell_2nd_game(uint _sell_price) public onlyMember{
        sell_price = _sell_price;
        seller = msg.sender;
    }
    
    function showBalance() public view returns(uint)
    {
        return address(this).balance;
    }
    
    function confirmPurchase(address _buyer) public onlyMember{
            if(sell_price* 1 ether == address(this).balance){
                make_payable(publisher).transfer(address(this).balance/5);
                make_payable(seller).transfer(address(this).balance);
                changeAddr(_buyer);
            }
            else 
                revert();
    }
    
    function buy2nd() public payable{
        buyer = msg.sender;
    }
    
    
    // function sell(address addr, uint _sell_price) onlyMember public {
    //     sellsc sc = new sellsc();
    //     sc.setPrice(_sell_price);
    //     sc.getPrice();
        
    // }
    
}

// contract sellsc{
//     address public seller;
//     uint public sell_price;
//     uint public sell_time;
//     // constructor(address _seller, uint _sell_price) public {

//     //     sell_time = now;
//     //     seller = _seller;
//     //     sell_price = _sell_price;
//     //     // game_title = _game_title;
//     //     // game_publisher = _game_publisher;
//     //     // changeNum = 0;
//     //     // memNum = 1;

//     // }
//     function setPrice(uint _sell_price) public {
//         sell_price = _sell_price;
//     }
//     function getPrice() view public returns(uint) {
//         return sell_price;
//     }
// }


    
    
