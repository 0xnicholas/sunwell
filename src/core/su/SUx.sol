// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.28;

library SUx {
    uint256 internal constant ONE = 1e18;

    function suToAsset(uint256 exchangeRate, uint256 suAmount) internal pure returns (uint256) {
        return (suAmount * exchangeRate) / ONE;
    }

    function suToAssetCeiling(uint256 exchangeRate, uint256 suAmount) internal pure returns (uint256) {
        return (suAmount * exchangeRate + ONE - 1) / ONE;
    }

    function assetToSu(uint256 exchangeRate, uint256 assetAmount) internal pure returns (uint256) {
        return (assetAmount * ONE) / exchangeRate;
    }

    function assetToSuCeiling(uint256 exchangeRate, uint256 assetAmount) internal pure returns (uint256) {
        return (assetAmount * ONE + exchangeRate - 1) / exchangeRate;
    }
}