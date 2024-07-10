import sys
import math
from eth_abi import encode


x = int(sys.argv[1])
y = int(sys.argv[2])

# Encode
result = "0x" + encode(["uint256"], [x+y]).hex()
print(result)
