pragma solidity ^0.6.6;

/**
 * @title IFlashLoanReceiver interface
 * @notice Interface for the Aave fee IFlashLoanReceiver.
 * @author Suruj Kalita
 * @dev Implement this interface to develop a flashloan-compatible flashLoanReceiver contract
 */

interface IFlashLoanReceiver {

    /**
     * @dev This function is called after your contract has received the flash loaned amount
     * @param _reserve The address of the token being flash-borrowed
     * @param _amount The amount borrowed
     * @param _fee The additional fee to repay
     * @param _params Arbitrary params passed from the flash loan call
     */
    function executeOperation(
        address _reserve,
        uint256 _amount,
        uint256 _fee,
        bytes calldata _params
    ) external;
}