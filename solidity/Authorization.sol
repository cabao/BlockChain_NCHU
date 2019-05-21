pragma solidity 0.5.0;

contract Authorization{
    uint public cost;
    string public data_period;
    string public data_type;
    string public buyer_pubkey;
    string public received_message;
    address payable public data_owner;   
    address payable public data_buyer;
    enum State { Created, Locked, finished}
    State public state;     
    
    modifier priceEqual() {
     require(msg.value == cost*1 ether);
     _;
    }

    modifier onlyBuyer() {
     require(msg.sender == data_buyer);
     _;
    }

    function setPrice(uint x,string memory y,string memory z) public {
    cost = x;
    data_period = y;
    data_type = z;
    data_owner = msg.sender;
    state = State.Created;
    }

    function get() public view returns (uint) {
        return cost;
    }

    function confirmPurchase(string memory w) public
    priceEqual
    payable
    {
        buyer_pubkey = w;
        data_buyer = msg.sender;
        state = State.Locked;
    }


    function confirmReceived(string memory m) public
    onlyBuyer
    {

        received_message = m;
        delete cost;
        data_owner.transfer(address(this).balance);
        state = State.finished;

    }}