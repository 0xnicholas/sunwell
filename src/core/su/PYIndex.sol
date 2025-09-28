// SPDX-License-Identifier: GPL-3.0-or-later

pragma solidity ^0.8.28;

import "../../interfaces/IYieldToken.sol";
import "../../interfaces/IPrincipalToken.sol";

import "./SUx.sol";
import "../libraries/math/Math.sol";

type PYIndex is uint256;

library PYIndexLib {
    using Math for uint256;
    using Math for int256;

    function newIndex(IYieldToken YT) internal returns (PYIndex) {
        return PYIndex.wrap(YT.pyIndexCurrent());
    }

    function suToAsset(PYIndex index, uint256 suAmount) internal pure returns (uint256) {
        return SUx.suToAsset(PYIndex.unwrap(index), suAmount);
    }

    function assetToSu(PYIndex index, uint256 assetAmount) internal pure returns (uint256) {
        return SUx.assetToSu(PYIndex.unwrap(index), assetAmount);
    }

    function assetToSuCeiling(PYIndex index, uint256 assetAmount) internal pure returns (uint256) {
        return SUx.assetToSuCeiling(PYIndex.unwrap(index), assetAmount);
    }

    function suToAssetCeiling(PYIndex index, uint256 suAmount) internal pure returns (uint256) {
        uint256 _index = PYIndex.unwrap(index);
        return SUx.suToAssetCeiling(_index, suAmount);
    }

    ///

    function suToAsset(PYIndex index, int256 suAmount) internal pure returns (int256) {
        int256 sign = suAmount < 0 ? int256(-1) : int256(1);
        return sign * (SUx.suToAsset(PYIndex.unwrap(index), suAmount.abs())).Int();
    }

    function assetToSu(PYIndex index, int256 assetAmount) internal pure returns (int256) {
        int256 sign = assetAmount < 0 ? int256(-1) : int256(1);
        return sign * (SUx.assetToSu(PYIndex.unwrap(index), assetAmount.abs())).Int();
    }

    function assetToSuCeiling(PYIndex index, int256 assetAmount) internal pure returns (int256) {
        int256 sign = assetAmount < 0 ? int256(-1) : int256(1);
        return sign * (SUx.assetToSuCeiling(PYIndex.unwrap(index), assetAmount.abs())).Int();
    }
}