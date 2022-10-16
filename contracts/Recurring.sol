pragma solidity 0.8.9;

contract Recurring{

    mapping(address=>uint256)balances;
    bytes32 notifyNewMonthStarted="NEW MONTH STARTED";
    event newMonthStarted(bytes32 notifyNewMonthStarted);
    event depositted(address user, uint256 amount);

    uint256 time= 365 days;
    uint256 month=30 days;

    function deposit() public payable{
        require(balances[msg.sender] > 0);
        balances[msg.sender] += msg.value;
        emit depositted(msg.sender, msg.value);

        
    }

    function withdraw(uint256 amount) public{
        
        require(block.timestamp >= time);
        require(amount > 0);
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
        
        
    }

    function notify() public{
        require(block.timestamp == month);
        emit newMonthStarted(notifyNewMonthStarted);

    }

    function balanceOf() public view returns (uint){
        return balances[msg.sender];
        
    }
}