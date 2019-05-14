pragma solidity >=0.4.22 < 0.6.0;

contract member_detail {
    
    struct Student{
        bool active;
        string name;
        uint score;
        uint startTime;
    }
    mapping(uint => Student) students;
    
    modifier already_active(uint _id){
        require(students[_id].active, "該生尚未註冊");
        _;
    }
    
    function register(uint _id, string memory _name) public{
        students[_id] = Student({
            active: true,
            name: _name, 
            score: 0, 
            startTime: now 
        });
    }
    
    function modifyScore(uint _id, uint _score) public already_active(_id){
        students[_id].score = _score;
    }
    
    function getStudent(uint _id) public already_active(_id) view returns (string memory, uint, uint){
        return (students[_id].name, students[_id].score, students[_id].startTime);
    }
}