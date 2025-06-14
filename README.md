# GetDonation Smart Contract

A Solidity smart contract designed to facilitate the reception and management of donations on the Ethereum blockchain.

## Overview

GetDonation is a smart contract that allows users to send donations (tips) in ETH and provides functionality for the contract owner to manage these funds.

## Key Features

### 1. Owner Management
- The contract has an owner address set during deployment
- `onlyOwner` modifier ensures certain functions can only be executed by the contract owner

### 2. Events
- `TipReceived`: Emitted when a donation is received, including sender address and amount
- `OwnershipTransferred`: Emitted when contract ownership is transferred
- `Withdrawn`: Emitted when the owner withdraws funds from the contract

### 3. Donations
The `tip` function allows anyone to send ETH to the contract as a donation:
- Ensures the sent amount is greater than 0
- Emits the `TipReceived` event upon successful donation

### 4. Withdrawals
The `withdraw` function enables the owner to withdraw the total contract balance:
- Verifies available funds
- Ensures successful fund transfer
- Emits the `Withdrawn` event upon successful withdrawal

### 5. Ownership Transfer
The `transferOwnership` function allows the current owner to transfer ownership to a new address:
- Validates the new owner's address
- Ensures the new address is different from the current owner
- Emits the `OwnershipTransferred` event

### 6. Balance Queries
- `getContractBalance`: Returns the current contract balance
- `getOwnerBalance`: Returns the current owner's address balance

### 7. Fallback Function
- The `receive` function allows the contract to receive ETH directly
- Emits the `TipReceived` event when ETH is received

## Usage

### Making Donations
Anyone can make a donation to the contract using the `tip` function. The donation must be greater than 0 ETH.

### Withdrawing Funds
Only the owner can withdraw accumulated funds from the contract using the `withdraw` function.

### Transferring Ownership
The owner can transfer contract ownership to a new address using the `transferOwnership` function.

## Development

This project is built using Foundry. To get started:

1. Install Foundry
2. Clone this repository
3. Run `forge install` to install dependencies
4. Run `forge test` to run tests

## License

This project is licensed under the MIT License.
