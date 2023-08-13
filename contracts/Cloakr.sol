// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Cloakr {
    address public owner;

    modifier noOwner() {
        require(msg.sender != owner, "Owner cannot call this function");
        _;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only Owner can call this function");
        _;
    }

    struct User {
        string name;
        string username;
        string email;
    }

    mapping(address => User) public users;

    constructor() {
        owner = msg.sender;
    }

    function signUp(string memory _name, string memory _username, string memory _email) external noOwner {
        require(bytes(_name).length > 0, "Name is required");
        require(bytes(_username).length > 0, "Username is required");
        require(bytes(_email).length > 0, "Email is required");

        // Check if the user is not already registered
        if (bytes(users[msg.sender].username).length == 0) {
            users[msg.sender] = User(_name, _username, _email);
        }
    }

    function getUserInfo(address _userAddress) external view onlyOwner returns (string memory, string memory, string memory) {
        User memory user = users[_userAddress];
        return (user.name, user.username, user.email);
    }

    function sendEther(address payable _recipient) external payable {
        require(msg.value > 0, "Amount must be greater than 0");
        require(_recipient != address(0), "Recipient address is required");
        //require(bytes(users[_recipient].name).length > 0, "Recipient address is not registered");

        uint256 totalAmount = msg.value;
        uint256 ownerShare = (totalAmount * 20) / 100;
        uint256 recipientAmount = totalAmount - ownerShare;

        _recipient.transfer(recipientAmount);
        payable(owner).transfer(ownerShare);
    }
}