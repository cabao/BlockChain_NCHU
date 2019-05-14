pragma solidity >=0.4.22 < 0.6.0;


contract constructor_detail{
    string public company_name;
    uint public money;
    uint public startTime;
    address public owner;
    address public charity;
    
    constructor (string memory _company_name, address _charity) public {
        owner = msg.sender;
        company_name = _company_name;
        charity = _charity;
        startTime = now;
    }
}
    
