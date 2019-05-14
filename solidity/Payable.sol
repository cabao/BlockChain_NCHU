pragma solidity >=0.4.22 < 0.6.0;

contract pay_to_me{
    
    event Log_fallback(string message, uint balance);
    
    function paytomeplz() public payable{
        emit Log_fallback("Fallback", address(this).balance);
    }
}