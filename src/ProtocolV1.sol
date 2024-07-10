// SPDX-License-Identifier: None

pragma solidity ^0.8.0;

contract ProtocolV1 {
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
        // FIXME: Bug here
        // triggered by user free mint
        if (block.timestamp > globalTimeThreshold) {
            // update the globalTimeThreshold with multiple of freeMintCooldownWindow until it is greater than block.timestamp
            while (block.timestamp > globalTimeThreshold) {
                globalTimeThreshold += freeMintCooldownWindow;
            }
        }
    }
}
