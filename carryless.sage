
R.<x> = PolynomialRing(GF(2))

def array2poly(t):
    coefficients = []
    for c in t:
        binary_rep = format(c,'08b')
        binary_rep = "".join(reversed(binary_rep))
        coefficients.extend(map(int,binary_rep))
    P = R(coefficients)
    return P
print ("===============\n\n")

P = x^7 + x^4 + 1
X_32 = x^32
mu,_ = X_32.quo_rem(P)
print("mu = ", mu)

def computeCRC(m):
    print("computeCRC\n")
    Pmsg = array2poly(m)
    print(" ".join( [hex(i) for i in m]), " -> ", Pmsg)
    Pmsg = Pmsg * x^7
    _, crc = Pmsg.quo_rem(P)
    print("CRC = ", crc)
    print("================\n")


def compute_using_carryless_CRC(m):
    print("computeCRC carryless\n")
    Pmsg = array2poly(m)
    print(" ".join( [hex(i) for i in m]), " -> ", Pmsg)
    Pmu = Pmsg * mu
    print("Pmsg*mu = ", Pmu)
    Pmu, _ = Pmu.quo_rem(x^32)
    print("Pmsg*mu/x32 = ", Pmu)
    PmuP = Pmu * P
    print("PmuP = ", PmuP)
    CRC = PmuP + Pmsg
    print("CRC carryless = ", CRC)
    print("================\n")

#msg = [0xEF, 0x44, 0x82, 0x81]
#compute_using_carryless_CRC(msg)
#msg.reverse()
#compute_using_carryless_CRC(msg)
#msg = [0xEF]
#compute_using_carryless_CRC(msg)
#msg = [0, 0xEF]
#compute_using_carryless_CRC(msg)
#msg = [0, 0, 0xEF]
#compute_using_carryless_CRC(msg)
#msg = [0, 0, 0, 0xEF]
#compute_using_carryless_CRC(msg)
#computeCRC(msg)
msg = [0xEF]
compute_using_carryless_CRC(msg)
computeCRC(msg)

