// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./vETH.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract LSTVault is ReentrancyGuard {
    vETH public immutable vToken;
    uint256 public totalBufferedETH;

    event Staked(address indexed user, uint256 ethAmount, uint256 vAmount);
    event RewardsRecognized(uint256 amount);

    constructor() {
        vToken = new vETH();
    }

    function getExchangeRate() public view returns (uint256) {
        uint256 supply = vToken.totalSupply();
        if (supply == 0) return 1e18; // 1:1 Initial rate
        return (address(this).balance * 1e18) / supply;
    }

    function stake() external payable nonReentrant {
        require(msg.value > 0, "Zero deposit");
        
        uint256 vAmount = (msg.value * 1e18) / getExchangeRate();
        totalBufferedETH += msg.value;
        
        vToken.mint(msg.sender, vAmount);
        emit Staked(msg.sender, msg.value, vAmount);
    }

    // Function for validators to send rewards back to the vault
    receive() external payable {
        emit RewardsRecognized(msg.value);
    }

    function totalAssets() public view returns (uint256) {
        return address(this).balance;
    }
}
