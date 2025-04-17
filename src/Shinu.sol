// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;
import {ERC20} from "../node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {Ownable} from "../node_modules/@openzeppelin/contracts/access/Ownable.sol";

contract Shinu is ERC20, Ownable {
    constructor() ERC20("Shinu", "SHI") Ownable(msg.sender) {}

    function mint(address _to, uint amount) public onlyOwner {
        _mint(_to, amount);
    }
}
