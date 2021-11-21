// SPDX-License-Identifier: Nolicense
pragma solidity 0.8.4;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

contract BlockS is ERC20 {
    constructor(string memory _name, string memory _symbol)
        ERC20(_name, _symbol)
    {
        _mint(msg.sender, 10000 * 10**uint256(decimals()));
    }
}