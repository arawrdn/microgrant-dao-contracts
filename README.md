# MicroGrantDAO

Minimal On-chain DAO for Micro-Grants on **Base Network**.  
Owner dapat membuat proposal hibah, anggota bisa voting, dan dana dieksekusi jika proposal didukung mayoritas.

## ✨ Features
- Buat proposal hibah (grant) oleh owner
- Voting (for / against) oleh anggota
- Eksekusi proposal (transfer ETH) jika disetujui
- Semua aktivitas tercatat on-chain melalui event

## 📜 Smart Contract
- Solidity version: `0.8.30`
- License: MIT
- Deployed at: [0x...](https://basescan.org/address/0x...)  
  _(ganti dengan alamat deploy kamu di BaseScan)_

## 🚀 Usage
1. Kirim ETH ke kontrak (`receive()`)
2. Owner buat proposal:
   ```solidity
   createProposal("Grant 1 ETH to Alice", 0xRecipientAddress, 1 ether);

