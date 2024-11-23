//SPDX-Lisence-Identifier: MIT
pragma solidity ^0.8.28;
import "forge-std/Script.sol";
import "../src/GetDonation.sol";

contract GetDonationScript is Script {
    GetDonation public getDonation;

    function setUp() public {}

    function run() public {
        uint privateKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(privateKey);

        //Desplegar el contrato
        getDonation = new GetDonation();
        console.log("Contract Deployed in: ", address(getDonation));

        vm.stopBroadcast();
    }
}
