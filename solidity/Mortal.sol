pragma solidity >=0.4.22 < 0.6.0;

contract father {
    address payable public owner;
    
    function f() public {
        owner = msg.sender;
    }
    
    function kill() public {
        selfdestruct(owner);
    }
}

contract son is father {
    string public userName;
    
    function s(string memory _name) public {
        userName = _name;
    }
}