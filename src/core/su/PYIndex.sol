// SPDX-License-Identifier: GPL-3.0-or-later

pragma solidity ^0.8.28;

import "../../interfaces/IYieldToken.sol";
import "../../interfaces/IPrincipalToken.sol";

import "./SUx.sol";
// import "../libraries/"
import "@openzeppelin/contracts/utils/math/Math.sol";

type PYIndex is uint256;

library PYIndexLib {
    using Math for uint256;

}