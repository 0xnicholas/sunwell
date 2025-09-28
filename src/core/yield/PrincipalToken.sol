// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.28;

import "../../interfaces/IPrincipalToken.sol";
import "../../interfaces/IYieldToken.sol";

import "../libraries/helper/TermHelper.sol";

import "../mip3/SunwellMIP3.sol";

import "@openzeppelin/contracts/proxy/utils/Initializable.sol";

contract PrincipalToken is SunwellMIP3, Initializable, IPrincipalToken {
    address public immutable SU;
    address public immutable factory;
    uint256 public immutable expiry;
    address public YT;

    error OnlyYT();
    error OnlyYieldFactory();

    modifier onlyYT() {
        if (msg.sender != factory) revert OnlyYT();
        _;
    }

    modifier onlyYieldFactory() {
        if (msg.sender != factory) revert OnlyYieldFactory();
        _;
    }

    constructor(
        address _SU,
        string memory _name,
        string memory _symbol,
        uint8 __decimals,
        uint256 _expiry
    ) SunwellMIP3(_name, _symbol, __decimals) {
        SU = _SU;
        expiry = _expiry;
        factory = msg.sender;
    }

    function initialize(address _YT) external initializer onlyYieldFactory {
        YT = _YT;
    }

    function burnByYT(address user, uint256 amount) external onlyYT {
        _burn(user, amount);
    }

    function mintByYT(address user, uint256 amount) external onlyYT {
        _mint(user, amount);
    }

    function isExpired() public view returns (bool) {
        return TermHelper.isCurrentlyExpired(expiry);
    }
}