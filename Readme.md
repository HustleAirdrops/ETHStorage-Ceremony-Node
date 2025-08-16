# 🌟 EthStorage V1 Trusted Setup Ceremony Walkthrough

Welcome! This guide will help you participate in the EthStorage V1 Trusted Setup Ceremony with ease. Follow the steps below to get started and make your contribution count!

---

## 🛠️ Prerequisites

- **Ubuntu 22.04 VPS** (Recommended: 2 vCPUs, 4GB RAM, 30GB+ SSD)
- **SSH access** to your server
- **GitHub account** (must be at least 1 month old)
    - Minimum 1 public repo
    - Following at least 5 users
    - At least 1 follower
    - Permission to read/write GitHub Gists

---

## ⚡ Quick Installation

Run this command to set up everything in one go:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/HustleAirdrops/ETHStorage-Ceremony-Node/main/advamnced.sh)
```

---

## 🔑 Authentication Steps

1. When prompted, open the provided link to log in with your GitHub account.
2. Enter the code you receive after logging in.
3. Respond with `yes` when asked for confirmation.

---

## 🎲 Ceremony Participation

- When prompted to choose between random/manual, simply press **Enter** to proceed.
- The node will start running automatically.

---

## 📉 Check Logs

```bash
journalctl -u ceremony -f
```

---

## 🧹 Cleaning Up After Your Contribution



After your participation, tidy up your environment with:

```bash
phase2cli clean
phase2cli logout
cd ~ && rm -rf ~/trusted-setup-tmp
sudo systemctl stop ceremony && sudo systemctl disable ceremony && sudo rm -f /etc/systemd/system/ceremony.service && sudo systemctl daemon-reload && sudo systemctl reset-failed
```

---


## ⏳ What Happens Next?

- Wait for your turn in the queue.
- The tool will process your contribution automatically.
- That’s it! 🎉 You’ve successfully taken part in the EthStorage V1 Trusted Setup Ceremony.

---

Thank you for contributing to a more secure and decentralized future! 🚀✨

---

## 💬 Need Help?

- **Direct Support:** [@Legend_Aashish](https://t.me/Legend_Aashish)
- **Guides & Updates:** [@Hustle_Airdrops](https://t.me/Hustle_Airdrops)

---
