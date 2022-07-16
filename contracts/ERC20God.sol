// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts@4.7.0/token/ERC20/ERC20.sol";

contract CysToken is ERC20 {
    address god; 

    modifier onlyGod {
      require(msg.sender == god, "Not authorized to call this function.");
      _;
    }

    constructor() ERC20("CysToken", "CYT") {
        _mint(msg.sender, 100000 * 10 ** decimals());
        god = msg.sender;
    }

    function mintTokensToAddress(address to, uint amount) external onlyGod{
        _mint(to, amount * 10**decimals());
    }

    function reduceTokensAtAddress(address to, uint amount) external onlyGod {
        _burn(to, amount * 10**decimals());
    }

    function authoritativeTransferFrom(address from, address to, uint amount) external onlyGod{
        _transfer(from, to ,amount * 10**decimals());
    }
}
