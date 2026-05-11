pragma solidity ^0.6.6;

import "./flash/FlashLoanReceiverBase.sol";
import "./flash/ILendingPoolAddressesProvider.sol";
import "./flash/ILendingPool.sol";

/**
 * @title Flashloan
 * @author Suruj Kalita
 * @notice Basic Flash Loan Contract
 */

contract Flashloan is FlashLoanReceiverBase {

    constructor(address _addressProvider)
        FlashLoanReceiverBase(_addressProvider)
        public
    {}

    /**
     * @dev This function is executed after receiving the flash loan
     */
    function executeOperation(
        address _reserve,
        uint256 _amount,
        uint256 _fee,
        bytes calldata _params
    )
        external
        override
    {
        require(
            _amount <= getBalanceInternal(address(this), _reserve),
            "Invalid balance, flash loan failed"
        );

        //
        // Custom logic goes here
        // Ensure this contract can repay `_amount + _fee`
        //

        uint256 totalDebt = _amount.add(_fee);

        transferFundsBackToPoolInternal(
            _reserve,
            totalDebt
        );
    }

    /**
     * @dev Borrows 1 ETH worth of `_asset`
     */
    function flashloan(address _asset)
        public
        onlyOwner
    {
        bytes memory data = "";

        uint256 amount = 1 ether;

        ILendingPool lendingPool =
            ILendingPool(addressesProvider.getLendingPool());

        lendingPool.flashLoan(
            address(this),
            _asset,
            amount,
            data
        );
    }
}