//SPDX-Lisence-Identifier:MIT
pragma solidity ^0.8.28;

contract GetDonation {
    address payable public owner;

    //Programa events
    event TipReceived(address indexed from, uint256 amount);
    event OwnerShipTransfered(address indexed previosOwner, address indexed newOwner);
    event WithDrawn(address indexed owner, uint256 amount);

    constructor() {
        owner = payable(msg.sender);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not contract owner");
        _;
    }

    //function to receive donation
    function tip() public payable {
        require(msg.value > 0, "You must send more than 0 ETH");
        payable(address(this)).transfer(msg.value);
        emit TipReceived(msg.sender, msg.value);
    }

    //function withdraw donation
    function withDraw() public onlyOwner {
        uint256 amount = address(this).balance;
        require(amount > 0, "Not founds to withdraw");
        uint256 prevBlance = address(this).balance;

        (bool success,) = owner.call{value: amount}("");
        require(success, "Transfer fail.");

        require(address(this).balance == prevBlance - amount);
        emit WithDrawn(owner, amount);
    }

    //function to transfer the contract
    function transferOwnerShip(address payable newOwner) public onlyOwner {
        require(newOwner != address(0), "New address invalid");
        require(newOwner != owner, "New address must be different");
        address oldOwner = owner;
        owner = newOwner;
        emit OwnerShipTransfered(oldOwner, newOwner);
    }

    //function to get contract balance
    function getContractBalance() public view returns (uint256) {
        return address(this).balance;
    }

    //function to get owner balance
    function getOwnerBalance() public view returns (uint256) {
        return owner.balance;
    }

    receive() external payable {
        emit TipReceived(msg.sender, msg.value);
    }
}
