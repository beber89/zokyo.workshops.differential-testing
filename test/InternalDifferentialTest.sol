// SPDX-License-Identifier: None

pragma solidity ^0.8.0;

import {ProtocolV1} from "src/ProtocolV1.sol";
import {ProtocolV2} from "src/ProtocolV2.sol";
import {Test, console} from "forge-std/Test.sol";

contract InternalDifferentialTest is Test {
    ProtocolV1 public protocolV1;
    ProtocolV2 public protocolV2;

    function setUp() public {
        protocolV1 = new ProtocolV1(100);
        protocolV2 = new ProtocolV2(100);
    }

    /**
     * @notice Compare the globalTimeThreshold after updating it
     * @dev without bounding the timestamp, ProtocolV1 will run out of gas
     * @param timestamp The timestamp to warp to
     */
    function testCompareUpdateGlobalTimeThreshold(uint256 timestamp) public {
        timestamp = bound(timestamp, 0, block.timestamp + 100000);
        vm.warp(timestamp);
        uint256 snapshot = vm.snapshot();
        // ACTION
        protocolV1.updateGlobalTimeThreshold();
        uint256 v1GlobalTimeThreshold = protocolV1.globalTimeThreshold();

        vm.revertTo(snapshot);
        // ACTION
        protocolV2.updateGlobalTimeThreshold();
        uint256 v2GlobalTimeThreshold = protocolV2.globalTimeThreshold();

        // POSTCONDITION
        assertEq(v1GlobalTimeThreshold, v2GlobalTimeThreshold);
    }
}
