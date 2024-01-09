//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract BuyMeACoffee {
    // deploy it on sepolia and front end using scafold-eth
    // make helper config file
    // do integration testing

    address payable public owner;

    constructor() {
        owner = payable(msg.sender);
    }

    struct Memo {
        address from;
        uint256 timestamp;
        string name;
        string message;
    }

    Memo[] public memos;

    function buyCoffee(
        string memory _name,
        string memory _message
    ) public payable {
        require(msg.value > 0, "can't buy coffee for free!");

        memos.push(Memo(msg.sender, block.timestamp, _name, _message));

        emit NewMemo(msg.sender, block.timestamp, _name, _message);
    }

    function withdrawTips() public {
        (bool success, ) = owner.call{value: address(this).balance}("");
        require(success, "Transfer failed");
    }

    event NewMemo(
        address indexed from,
        uint256 timestamp,
        string name,
        string message
    );

    function getMemos() public view returns (Memo[] memory) {
        return memos;
    }

    function getOwner() public view returns (address) {
        return owner;
    }
}
