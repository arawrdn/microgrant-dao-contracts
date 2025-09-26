# MicroGrantDAO

A minimal on-chain DAO for **micro-grants** on the Base Network.  
The owner can create grant proposals, members can vote, and funds are executed if the proposal has majority support.

## ✨ Features
- Owner creates grant proposals
- Members can vote **for** or **against**
- Proposal execution if approved (ETH transfer to recipient)
- Transparent on-chain events

## 📜 Smart Contract
- Solidity version: `0.8.30+`
- License: MIT
- Deployed at: [0xYourContractHere](https://basescan.org/address/0xYourContractHere)

## 🚀 How It Works
1. Deposit ETH into the DAO contract
2. Owner creates a proposal:
   ```solidity
   createProposal("Grant 1 ETH to Alice", 0xRecipientAddress, 1 ether);
