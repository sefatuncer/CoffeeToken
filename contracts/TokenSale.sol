// SPDX-License-Identifier: MIT

pragma solidity ^0.8.16;

import "contracts/CoffeeToken.sol";

// abstract contract ERC20 {
//        function transferFrom(address _from, address _to, uint256 _value) public virtual returns (bool success);
//        function decimals() public virtual view returns (uint8);
// }

contract TokenSale {

    uint public tokenPriceInWei = 1 ether;

    CoffeeToken public token;
    address public tokenOwner;

    constructor(address _token) {
        tokenOwner = msg.sender;
        token = CoffeeToken(_token);
    }

    function purchaseACoffee() public payable {
        require(msg.value >= tokenPriceInWei, "Not enough money sent");
        uint tokensToTransfer = msg.value / tokenPriceInWei;
        uint remainder = msg.value - tokensToTransfer * tokenPriceInWei;
        token.transferFrom(tokenOwner, msg.sender, tokensToTransfer * 10 * token.decimals());
        payable(msg.sender).transfer(remainder); // send the rest of money back
    }
}