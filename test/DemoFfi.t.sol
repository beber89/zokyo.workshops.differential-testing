// SPDX-License-Identifier: MIT
// Solidity version: 0.8.0
pragma solidity ^0.8.0;
import "forge-std/Test.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract DemoFfi is Test {
    using Strings for uint256;

    function testFfiForEcho() public {
        console.log(
            "##### echo 0x0000000000000000000000000000000000000000000000000000000000000010"
        );
        string[] memory cmds = new string[](2);
        cmds[0] = "echo";
        cmds[
            1
        ] = "0x0000000000000000000000000000000000000000000000000000000000000010";
        bytes memory result = vm.ffi(cmds);
        console.log("Raw result: ");
        console.logBytes(result);
        uint256 y = abi.decode(result, (uint256));
        console.log("Decoded result:\n", y);
    }

    function testFfiForCat() public {
        console.log("##### cat test/address.txt");
        string[] memory cmds = new string[](2);
        cmds[0] = "cat";
        cmds[1] = "test/address.txt"; // assume contains abi-encoded address.
        bytes memory result = vm.ffi(cmds);

        console.log("Raw result: ");
        console.logBytes(result);
        address y = abi.decode(result, (address));
        console.log("Decoded result:\n", y);
    }
}
