import struct
from random import random, randint


def float_to_a1(f: float) -> str:
    h = hex(struct.unpack("<I", struct.pack("<f", f))[0])
    bin_list = list(map(int, bin(int(h, 16))[2:].rjust(32, "0")))

    if any(bin_list[1:9]):
        bin_list[9:] = [1] + bin_list[9:-1]

    return bin_list


def verhex_to_a1(vh):
    return list(map(int, bin(int(vh[4:8] + vh[-4:], 16))[2:].rjust(32, "0")))


def a1_to_float(a1: str) -> float:
    a1[9:] = a1[10:] + [0]
    h = hex(int("".join(map(str, a1)), 2))[2:]
    return struct.unpack("!f", bytes.fromhex(h))[0]


def a1_to_verhex(a1):
    h = hex(int("".join(map(str, a1)), 2))
    return f"32'h{h[2:-4].rjust(4, '0')}_{h[6:].rjust(4, '0')}"


for i in range(50):
    a = random() * randint(-8_000_000, 8_000_000)
    b = random() * randint(-8_000_000, 8_000_000)
    a1_a = float_to_a1(a)
    a1_b = float_to_a1(b)
    a_hex = a1_to_verhex(a1_a)
    b_hex = a1_to_verhex(a1_b)
    res = a1_to_float(a1_a) + a1_to_float(a1_b)
    a1_res = float_to_a1(res)
    res_hex = a1_to_verhex(a1_res)
    # print(f"test_case({a_hex}, {b_hex}, {res_hex}); // {a} + {b} = {res}")
