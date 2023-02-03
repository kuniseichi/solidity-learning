// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

// import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

import "./interface/Uniswap.sol";
// import "./interface/IERC20.sol";

contract TestUniswap {
    address private constant UNISWAP_V2_ROUTER = 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D;
    address private constant WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;

    function swap (
        address _tokenIn,
        address _tokenOut,
        uint256 _amountIn,
        uint256 _amountOut,
        address _to
    ) external {
        // save to contract address
        IERC20(_tokenIn).transferFrom(msg.sender, address(this), _amountIn);
        // allow router withdraw tokenIn from contract address
        IERC20(_tokenIn).approve(UNISWAP_V2_ROUTER, _amountIn);

        address[] memory path;
        path = new address[](3);
        path[0] = _tokenIn;
        path[1] = WETH;
        path[2] = _tokenOut;

        IUniswapV2Router(UNISWAP_V2_ROUTER).swapExpectTokensForTokens(
            _amountIn,
            _amountOut,
            path,
            _to,
            block.timestamp
        );
    }
}