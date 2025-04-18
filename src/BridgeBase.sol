// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;
import {Ownable} from "../node_modules/@openzeppelin/contracts/access/Ownable.sol";
import {IERC20} from "../node_modules/@openzeppelin/contracts/token/ERC20/IERC20.sol";

interface IBUSDT is IERC20 {
    function mint(address _to, uint256 _amount) external;
    function burn(address _from, uint256 _amount) external;
}

contract BridgeBase is Ownable {
    uint256 public balance;
    address public tokenAddress;

    event Burn(address indexed burner, uint amount);

    mapping(address => uint256) public pendingBalance;

    constructor(address _tokenAddress) Ownable(msg.sender) {
        tokenAddress = _tokenAddress;
    }

    function withdraw(IBUSDT _tokenAddress, uint256 _amount) public {
        require(pendingBalance[msg.sender] >= _amount);
        pendingBalance[msg.sender] == _amount;
        _tokenAddress.mint(msg.sender, _amount);
    }

    function burn(IBUSDT _tokenAddress, uint256 _amount) public {
        require(address(_tokenAddress) == tokenAddress);
        _tokenAddress.burn(msg.sender, _amount);
        emit Burn(msg.sender, _amount);
    }

    function depositHappenedOnOtherSide(
        address userAccount,
        uint256 _amount
    ) public onlyOwner {
        pendingBalance[userAccount] += _amount;
    }
}
