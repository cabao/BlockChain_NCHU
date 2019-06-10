pragma solidity >=0.4.22 <0.6.0;
contract ebooksc{
    address public author;
    string public book_author;
    string public book_name;
    uint public book_price;
    uint public publish_time;
    uint public changeNum;
    uint public memNum ;


    struct mems{
        address mem_address;
        uint buy_time;
    }
    mapping (uint => mems) public membership;

    modifier priceEqual{
        require(msg.value == book_price* 1 ether);
        _;
    //18 x 0
    }
    modifier onlyAuthor {
        require (msg.sender ==author);
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

    constructor(address _author,string memory _book_name, string memory _book_author, uint _book_price) public {

        publish_time = now;
        author = _author;
        book_name = _book_name;
        book_author = _book_author;
        book_price = _book_price;
        changeNum = 0;
        memNum = 1;

    }

    function register(address _mem_address) public payable priceEqual{
        membership[memNum] = mems({
            mem_address : _mem_address,
            buy_time : now
        });
        memNum ++;

    }
    function change(address _changeAddress) public onlyMember{

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
    function getEther() onlyAuthor public {
        make_payable(author).transfer(address(this).balance);
    }
}