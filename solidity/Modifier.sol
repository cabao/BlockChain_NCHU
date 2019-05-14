pragma solidity >=0.4.22 < 0.6.0;


contract modifier_had{
    
    address payable public owner;
    uint16 count = 0;
    constructor() public{
        owner = msg.sender;
        
    }
    
    modifier onlyOwner(){
        require(msg.sender == owner);
        _;
    }
    
    function a() public onlyOwner returns(uint16){
        count++;
        return count;
    }
    function b() public onlyOwner{
        selfdestruct(owner);
    }
}
    
