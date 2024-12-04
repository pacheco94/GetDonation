//SPDX-License-Identifier:MTI

pragma solidity 0.8.28;

import "forge-std/Test.sol";
import "../src/GetDonation.sol";

contract GetDonationTest is Test {
    GetDonation public getDonation;

    address payable public alice;
    address payable public bob;
    address payable public carol;
    uint256 public initialBalance = 100 ether;

    event TipReceived(address indexed form, uint256 amount);
    event OwnerShipTransfered(address indexed previosOwner, address indexed newOwner);
    event WithDrawn(address indexed owner, uint256 amount);

    function setUp() public {
        alice = payable(makeAddr("alice"));
        bob = payable(makeAddr("bob"));
        carol = payable(makeAddr("carol"));

        vm.deal(alice, initialBalance);
        vm.deal(bob, initialBalance);
        vm.deal(carol, initialBalance);

        vm.prank(alice);
        getDonation = new GetDonation();
    }

    //Testing correct contract owner alice
    function test_ownerContract() public {
        assertEq(alice, getDonation.owner());
        emit log("alice is the owner");
    }

    //Testing tip funciton with 0 balance
    function test_TipWithZeroBalance() public {
        vm.prank(bob);
        vm.expectRevert("You must send more than 0 ETH");
        getDonation.tip{value: 0}();
    }

    //Testing tip with ether
    function test_TipWithEther() public {
        uint256 amount = 7 ether;
        uint256 preContractBalance = getDonation.getContractBalance();
        vm.prank(carol);
        vm.expectEmit();
        emit TipReceived(carol, amount);
        getDonation.tip{value: amount}();
        assertEq(address(getDonation).balance, preContractBalance + amount);
    }

    // Testing multiple tip fuzzing test
    function test_FuzzingTip(uint256 _amount) public {
        _amount = bound(_amount, 1, 100 ether);
        vm.deal(bob, _amount);
        uint256 initialContractBalance = address(getDonation).balance;
        vm.prank(bob);
        getDonation.tip{value: _amount}();
        assertEq(address(getDonation).balance, initialContractBalance + _amount);
    }

    //Test Withdraw function
    function test_WhidrawOnlyOwner() public {
        uint256 amount = 8 ether;
        uint256 initialOwnerBalance = alice.balance;
        uint256 initialContractBalance = address(getDonation).balance;

        //carol send ether
        vm.prank(carol);
        getDonation.tip{value: amount}();

        vm.prank(alice);
        vm.expectEmit();
        emit WithDrawn(alice, amount);
        getDonation.withDraw();

        assertEq(alice.balance, initialOwnerBalance + amount);
        assertEq(getDonation.getContractBalance(), initialContractBalance);
    }

    //test withdraw not owner
    function test_WhidrawNotOwnerCannot() public {
        uint256 amount = 1 ether;

        vm.prank(carol);
        getDonation.tip{value: amount}();

        vm.prank(bob);
        vm.expectRevert("You are not contract owner");
        getDonation.withDraw();
    }

    //test function transfer contract transferOwnerShip()
    function test_TransferingOwnerShip() public {
        vm.prank(alice);
        vm.expectEmit();
        emit OwnerShipTransfered(alice, bob);
        getDonation.transferOwnerShip(bob);

        assertEq(getDonation.owner(), bob);
    }

    //testing require in funciton transferOwnerShip()
    function test_CannotTransferToZeroAddress() public {
        vm.prank(alice);
        vm.expectRevert("New address invalid");
        getDonation.transferOwnerShip(payable(address(0)));
    }

    //testing same contract address
    function test_CannotTransferToSameOwnerAddress() public {
        vm.prank(alice);
        vm.expectRevert("New address must be different");
        getDonation.transferOwnerShip(alice);
    }

    //testing Receiving function
    function test_ReceivenFunction() public {
        uint256 sendAmount = 3 ether;

        //bob send ether to the contract
        vm.prank(bob);
        vm.expectEmit();
        emit TipReceived(bob, sendAmount);

        (bool success,) = address(getDonation).call{value: sendAmount}("");
        require(success, "Transfer fail");

        assertEq(address(getDonation).balance, sendAmount);
    }

    receive() external payable {}
}
