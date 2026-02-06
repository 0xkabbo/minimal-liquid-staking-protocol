# Minimal Liquid Staking Protocol

This repository contains the core smart contract logic for a **Liquid Staking Token (LST)**. It enables users to deposit native assets to earn staking yield while maintaining capital efficiency through a liquid derivative token.

## How it Works
1. **Stake:** User deposits ETH into the `LSTVault`.
2. **Mint:** The protocol mints `vETH` (Vault ETH) based on the current exchange rate.
3. **Accrue:** As validator rewards are "pushed" into the contract, the amount of ETH backing each `vETH` increases.
4. **Redeem:** Users can burn `vETH` to claim their share of the total ETH pool (subject to unbonding periods).



## Key Components
* **Exchange Rate Logic:** `totalAssets() / totalSupply()` determines the value of the LST.
* **Reward Smoothing:** Logic to handle organic staking rewards and MEV (Maximal Extractable Value) injection.
* **Oracle Integration:** (Optional) Feeds for off-chain validator performance tracking.
