// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.28;

interface IInterestYT {
    function userInterest(
        address user
    ) external view returns (uint128 lastInterestIndex, uint128 accruedInterest, uint256 lastSUIndex);
}