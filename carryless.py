

def iclmul(rs1: int, rs2: int):
    x = 0
    for i in (0..32):
        if (rs2 >> i) & 1:
            x = x ^ (rs1 << i)
    return x  & ((1<<32)-1) # Ensure result fits within the intended bit range

def iclmulh(rs1: int, rs2: int):
    x = 0
    for i in range(1, 32):
        if (rs2 >> i) & 1:
            x ^= rs1 >> (32 - i)
    return x & ((1 << 32) - 1)  # Ensure result fits within XLEN bits

