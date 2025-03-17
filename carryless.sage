
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
QT,_ = X_32.quo_rem(P)
print("QT = ", QT)

def computeCRC(m, poly):
    print("computeCRC\n")
    print("   poly=", poly, "\n")
    Pmsg = array2poly(m)
    print(" ".join( [hex(i) for i in m]), " -> ", Pmsg)
    Pmsg = Pmsg * x^poly.degree()
    print("   msg=", Pmsg, "\n")
    _, crc = Pmsg.quo_rem(poly)
    print("CRC with modulo = ", crc)
    l = crc.list()
    l.reverse()
    s = "".join(map(str,l))
    d = int(s,2)
    print("crc hex = ",hex(d))

    print("================\n")
    return crc


def compute_using_carryless_CRC(m):
    print("computeCRC carryless\n")
    Pmsg = array2poly(m)
    print(" ".join( [hex(i) for i in m]), " -> ", Pmsg)
    PQT = Pmsg * QT
    print("Pmsg*QT = ", PQT)
    PQT, _ = PQT.quo_rem(X_32)
    print("Pmsg*QT/x32 = ", PQT)
    PQT = PQT + Pmsg
    print("Pmsg*QT/x32+Pmsg = ", PQT)
    PQTP = PQT * P
    print("PQTP = ", PQTP)
    CRC = PQTP + Pmsg
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
# compute_using_carryless_CRC(msg)
# computeCRC(msg)

msg = [0xEF]
m = x^7 + x^6 + x^5 + x^3 + x^2 + x + 1
M = m * x^7
qt,_ = (x^32).quo_rem(P)
a,_ = (M*qt).quo_rem(x^32)
a*P+M

# CRC32 : 100000100110000010001110110110111
CRC32 = x^32 + x^26 + x^23 + x^22 + x^16 + x^12 + x^11 + x^10 + x^8 + x^7 + x^5 + x^4 + x^2 + x + 1
computeCRC(msg,CRC32)

