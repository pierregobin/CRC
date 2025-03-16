#include <stdio.h>
#include <stdint.h>
const unsigned char CRC7_POLY = 0x91;

unsigned char getCRC(unsigned char message[], unsigned char length)
{
    unsigned char i, j, crc = 0;

    for (i = 0; i < length; i++)
    {
        crc ^= message[i];
        for (j = 0; j < 8; j++)
        {
            if (crc & (1 << 7))
                crc ^= CRC7_POLY;
            if (i!=(length-1)) {
                crc <<= 1;
            }
            else {
                if (j!=7) crc <<= 1;
            }
        }
    }
    return crc;
}

#define XLEN 32
uint32_t clmul(uint32_t rs1, uint32_t rs2)
{
    uint32_t x = 0;
    for (int i = 0; i < XLEN; i++)
    if ((rs2 >> i) & 1)
            x ^= rs1 << i;
    return x;
}
uint32_t clmulh(uint32_t rs1, uint32_t rs2)
{
    uint32_t x = 0;
    for (int i = 1; i < XLEN; i++)
    if ((rs2 >> i) & 1)
            x ^= rs1 >> (XLEN-i);
    return x;
}

uint32_t clmulr(uint32_t rs1, uint32_t rs2)
{
    uint32_t x = 0;
    for (int i = 0; i < XLEN; i++)
    if ((rs2 >> i) & 1)
            x ^= rs1 >> (XLEN-i-1);
    return x;
}

int main()
{
    // create a message array that has one extra byte to hold the CRC:
    unsigned char message[5] = { 0xEF, 0x44, 0x82, 0x81, 0x00};
    message[4] = getCRC(message, 4);
    printf("CRC = 0x%0x\n",message[4]);
    uint32_t msg = 0xEF448281;
    uint32_t q = clmul(clmulh(msg,0x24d3dc3),0x91) ^ msg;
    printf("q   = 0x%0x\n",q);
    msg = 0x818244EF;
    q = clmul(clmulh(msg,0x24d3dc3),0x91) ^ msg;
    printf("q   = 0x%0x\n",q);
    // send this message to the Simple Motor Controller
}

