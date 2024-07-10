pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract AdderContract is Test {
    function add(uint256 a, uint256 b) public pure returns (uint256) {
        return a + b;
    }

    function testContractVsTsAdd(uint32 a, uint32 b) public {
        string[] memory runTsInputs = new string[](5);
        runTsInputs[0] = "npx";
        runTsInputs[1] = "ts-node";
        runTsInputs[2] = "test/add.ts";
        runTsInputs[3] = Strings.toString(a);
        runTsInputs[4] = Strings.toString(b);

        bytes memory tsResult = vm.ffi(runTsInputs);
        uint256 tsAdd = abi.decode(tsResult, (uint256));

        uint256 solAdd = add(a, b);

        assertEq(tsAdd, solAdd);
    }

    function testContractVsPyAdd(uint32 a, uint32 b) public {
        string[] memory runTsInputs = new string[](5);
        runTsInputs[0] = "python";
        runTsInputs[1] = "test/add.py";
        runTsInputs[2] = Strings.toString(a);
        runTsInputs[3] = Strings.toString(b);

        bytes memory tsResult = vm.ffi(runTsInputs);
        uint256 pyAdd = abi.decode(tsResult, (uint256));

        uint256 solAdd = add(a, b);

        assertEq(pyAdd, solAdd);
    }
}
