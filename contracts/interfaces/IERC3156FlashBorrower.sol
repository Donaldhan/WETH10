// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <=0.8.0;


interface IERC3156FlashBorrower {

    /**
     * @dev Receive a flash loan.
     * @param initiator The initiator of the loan.  借贷发起者
     * @param token The loan currency.
     * @param amount The amount of tokens lent.
     * @param fee The additional amount of tokens to repay. 需要偿的费用
     * @param data Arbitrary data structure, intended to contain user-defined parameters.
     * @return The keccak256 hash of "ERC3156FlashBorrower.onFlashLoan" 返回ERC3156FlashBorrower.onFlashLoan的hash
     */
    function onFlashLoan(
        address initiator,
        address token,
        uint256 amount,
        uint256 fee,
        bytes calldata data
    ) external returns (bytes32);
}
