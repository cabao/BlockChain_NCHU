pragma solidity >=0.4.22 < 0.6.0;

contract enume {
    enum State {New, Used, Scrapped}
    State public status;
    
    function One() public{
        status = State.New;
    }
    
    function Done() public{
        status = State.Used;
    }
    
    function Scrap() public{
        status = State.Scrapped;
    }
}