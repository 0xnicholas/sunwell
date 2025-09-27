// SPDX-License-Identifier: GPL-3.0-or-later

pragma solidity ^0.8.28;

import "./SunwellMIP3.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/IERC20Permit.sol";
import "@openzeppelin/contracts/utils/cryptography/EIP712.sol";
import "@openzeppelin/contracts/utils/Nonces.sol";
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";


contract SunwellMIP3Permit is SunwellMIP3, IERC20Permit, EIP712, Nonces {
    
    bytes32 private constant _PERMIT_TYPEHASH =
        keccak256("Permit(address owner,address spender,uint256 value,uint256 nonce,uint256 deadline)");

    constructor(
        string memory name_,
        string memory symbol_,
        uint8 decimals_
    ) SunwellMIP3(name_, symbol_, decimals_) EIP712(name_, "1") {}

    function permit(
        address owner,
        address spender,
        uint256 value,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) public virtual override {
        require(block.timestamp <= deadline, "MIP3Permit: expired deadline");

        bytes32 structHash = keccak256(abi.encode(_PERMIT_TYPEHASH, owner, spender, value, _useNonce(owner), deadline));

        bytes32 hash = _hashTypedDataV4(structHash);

        address signer = ECDSA.recover(hash, v, r, s);
        require(signer == owner, "MIP3Permit: invalid signature");

        _approve(owner, spender, value);
    }

    function DOMAIN_SEPARATOR() external view override returns (bytes32) {
        return _domainSeparatorV4();
    }


    function nonces(address owner) public view override(IERC20Permit, Nonces) returns (uint256) {
        return Nonces.nonces(owner);
    }

    
    function _userNonce(address owner) internal virtual returns (uint256 current) {
        return _userNonce(owner);
    }
   
}