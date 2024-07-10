// SPDX-License-Identifier: None

pragma solidity ^0.8.0;

contract ProtocolV2 {
    uint256 public globalTimeThreshold;
    uint256 public freeMintCooldownWindow;

    constructor(uint256 _freeMintCooldownWindow) {
        freeMintCooldownWindow = _freeMintCooldownWindow;
        globalTimeThreshold = block.timestamp;
    }

    function updateGlobalTimeThreshold() external {
        _updateGlobalTimeThreshold();
    }

    function _updateGlobalTimeThreshold() internal {
        // triggered by user free mint
        if (block.timestamp > globalTimeThreshold) {
            // Calculate the number of periods that have passed
            uint256 periodsPassed = (block.timestamp - globalTimeThreshold) /
                freeMintCooldownWindow;

            // Add one more period to ensure it's greater than the current timestamp
            periodsPassed++;

            // Update the globalTimeThreshold in one step
            globalTimeThreshold += periodsPassed * freeMintCooldownWindow;
        }
    }
}
