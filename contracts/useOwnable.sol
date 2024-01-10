// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";

contract MyToken is Ownable  {

    uint256 public value;

    constructor(address initialOwner)
        Ownable(initialOwner)
    {
        value = 10;
    }

    function getValue() public view returns (uint256)  {
        return value;
    }

    function getValue_onlyOwner() public view onlyOwner returns (uint256)  {
        return value;
    }

    
}
