import struct
from random import random, randint


def float_to_hex(f):
    h = hex(struct.unpack("<I", struct.pack("<f", f))[0]).upper()
    # print(h)
    return f"32'h{h[2:-4].rjust(4, '0')}_{h[6:].rjust(4, '0')}"


def hex_to_float(h):
    h = h[4:8] + h[9:]
    return struct.unpack("!f", bytes.fromhex(h))[0]


for i in range(50):
    a = random() * randint(-8_000_000, 8_000_000)
    b = random() * randint(-8_000_000, 8_000_000)
    # res = a + b
    a_hex = float_to_hex(a)
    b_hex = float_to_hex(b)
    res = hex_to_float(a_hex) + hex_to_float(b_hex)
    res_hex = float_to_hex(res)
    print(f"test_case({a_hex}, {b_hex}, {res_hex});")
