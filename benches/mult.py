import struct
import ctypes
from random import uniform

utils = ctypes.CDLL("./utils.so")

py2float = utils.py2float
py2float.argtypes = [ctypes.c_float]
py2float.restype = ctypes.c_float
py2double = utils.py2double
py2double.argtypes = [ctypes.c_float]
py2double.restype = ctypes.c_double
mult_float = utils.mult_float
mult_float.argtypes = [ctypes.c_float, ctypes.c_float]
mult_float.restype = ctypes.c_float
mult_doubles = utils.mult_doubles
mult_doubles.argtypes = [ctypes.c_double, ctypes.c_double]
mult_doubles.restype = ctypes.c_double
mult_mult_doubles = utils.mult_true_doubles
mult_mult_doubles.argtypes = [ctypes.c_double, ctypes.c_double]
mult_mult_doubles.restype = ctypes.c_double

def generate_random():
    return uniform(-73786971896791695000, 73786971896791695000)

def double_to_hex(d):
    h = hex(struct.unpack("<Q", struct.pack("<d", d))[0]).upper()
    return h[2:].zfill(16)

def hex_to_double(h):
    return struct.unpack("!d", bytes.fromhex(h))[0]

def float_to_hex(f):
    h = hex(struct.unpack("<I", struct.pack("<f", f))[0]).upper()
    return h[2:].zfill(8)

def hex_to_float(h):
    return struct.unpack("!f", bytes.fromhex(h))[0]

def hex_to_bits(h):
    bits = bin(int(h, 16))[2:].zfill(32)
    return [int(b) for b in bits]

def bits_to_hex(bits):
    bits_bin = ''.join(map(str, bits))
    return hex(int(bits_bin, 2))[2:].zfill(8)

def normalized_bits_to_denormalized_bits(bits):
    s, e, f = bits[0], bits[1:9], bits[9:]
    if any(e):
        e_bin = ''.join(map(str, e))
        new_e_int = int(e_bin, 2) - 1
        new_e_bin = bin(new_e_int)[2:].zfill(8)
        e = [int(b) for b in new_e_bin]

        f = [1, *f][:-1]

    return [s, *e, *f]

def denormalized_bits_to_normalized_bits(bits):
    s, e, f = bits[0], bits[1:9], bits[9:]

    new_f = [0, *f]
    e_bin = ''.join(map(str, e))
    new_e_int = int(e_bin, 2)
    for i in range(23):
        if new_f[0] == 1:
            break

        new_f = [*new_f[1:], 0]
        new_e_int += 1
    
    new_e_bin = bin(new_e_int)[2:].zfill(8)
    new_e = [int(b) for b in new_e_bin]
    
    return [s, *new_e, *new_f[1:]]


tb_fmult = """`timescale 1ps/1ps

`include "fmult.v"

module fmult_tb;

reg [31:0] a, b;
wire [31:0] out;

reg clk = 1'b1;

fmult uut(a, b, out);

always clk = #5 ~clk;

initial begin

	$dumpfile("fmult_out.vcd");
	$dumpvars(0, fmult_tb);
##REPLACE_THIS##
    $finish;
end

task test_case(
    input [31:0] a_in,
    input [31:0] b_in,
); begin
    @(negedge clk) begin
        a = a_in;
        b = b_in;
    end
    @(posedge clk) begin
        $display("%h,%h,%h", a_in, b_in, out);
    end
end
endtask

endmodule
"""

tb_fmult_a1 = tb_fmult.replace("fmult", "fmult_a1")

NUMBER_OF_TESTS = 1000

def main():
    tb_fmult_tests = ""
    tb_fmult_a1_tests = ""
    double_mult_results = []
    for _ in range(NUMBER_OF_TESTS):
        a, b = generate_random(), generate_random()
        a_double, b_double = py2double(a), py2double(b)
        a_float, b_float = py2float(a), py2float(b)

        a_hex_float, b_hex_float = float_to_hex(a_float), float_to_hex(b_float)
        a_hex_denorm = bits_to_hex(normalized_bits_to_denormalized_bits(hex_to_bits(float_to_hex(a_float))))
        b_hex_denorm = bits_to_hex(normalized_bits_to_denormalized_bits(hex_to_bits(float_to_hex(b_float))))
        
        tb_fmult_tests += f"\ttest_case(32'h{a_hex_float}, 32'h{b_hex_float});\n"
        tb_fmult_a1_tests += f"\ttest_case(32'h{a_hex_denorm}, 32'h{b_hex_denorm});\n"
        double_mult_results.append(mult_doubles(a, b))

    with open("../src/fmult/tb_fmult_bench.v", "w") as f:
        f.open(tb_fmult.replace("##REPLACE_THIS##", tb_fmult_tests))
    
    # with open("../src/fmult/tb_fmult_a1_bench.v", "w") as f:
    #     f.write(tb_fmult_a1.replace("##REPLACE_THIS##", tb_fmult_a1_tests))

    subprocess.run(["iverilog", "tb_fmult_bench.v"], cwd="../src/fmult/")
    subprocess.run(["iverilog", "tb_fmult_a1_bench.v"], cwd="../src/fmult_a1/")

    results_float = (
        subprocess.run(["./a.out"], stdout=subprocess.PIPE, cwd="../src/fmult/")
        .stdout.decode("utf8")
        .splitlines()
    )
    float_result_list = [hex_to_float(h) for h in results_float]
    results_denorm = (
        subprocess.run(["./a.out"], stdout=subprocess.PIPE, cwd="../src/fmult_a1/")
        .stdout.decode("utf8")
        .splitlines()
    )
    denorm_result_list = [denormalized_hex_to_float(h) for h in results_denorm]

    denorm_errors = []
    float_errors = []
    print()
    for denorm, fnorm, double in zip(
        denorm_result_list,
        float_result_list,
        double_mult_results,
    ):
        denorm_errors.append((double - denorm) / double)
        float_errors.append((double - fnorm) / double)

    print(f"denormalized: {mean(denorm_errors)} ± {stdev(denorm_errors)}")
    print(f"float 754: {mean(float_errors)} ± {stdev(float_errors)}")

    subprocess.run(["rm", "./utils.so"])
    subprocess.run(["rm", "../src/fmult/a.out", "../src/fmult/tb_fmult_bench.v"])
    subprocess.run(["rm", "../src/fmult_a1/a.out", "../src/fmult_a1/tb_fmult_a1_bench.v"])

if __name__ == "__main__":
    main()
