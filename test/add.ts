// Run: ts-node add.ts 1 2
//
//

import { ethers } from "ethers";

const a = Number(process.argv[2]);
const b = Number(process.argv[3]);

const c = a + b;

// encode c to solidity uint256

console.log(ethers.utils.defaultAbiCoder.encode(["uint256"], [c]));

