// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/manager/AccessManaged.sol";

contract MyToken is AccessManaged {
    constructor(address initialAuthority)
        AccessManaged(initialAuthority)
    {}
}
