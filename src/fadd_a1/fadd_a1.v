`include "exponent_difference.v"
`include "mux.v"
`include "swap.v"
`include "r_shifter.v"
`include "u2_adder.v"

module fadd_a1 (
    input [31:0] a,
    input [31:0] b,
    output reg [31:0] out
);
    
    wire sign_a, sign_b;
    wire [7:0] exponent_a, exponent_b;
    wire [22:0] fraction_a, fraction_b;

    assign {sign_a, exponent_a, fraction_a} = a;
    assign {sign_b, exponent_b, fraction_b} = b;

    wire [8:0] exponent_diff;
    wire [7:0] exponent_diff_abs, exponent_larger;

    exponent_difference ED (exponent_a, exponent_b, exponent_diff);

    wire sign_d = exponent_diff[8];

    mux MUX (exponent_a, exponent_b, sign_d, exponent_larger);

    assign exponent_diff_abs = sign_d ? -exponent_diff : exponent_diff;

    wire [23:0] fraction_larger, fraction_shifted, fraction_smaller, fraction_preout, fraction_abs;
    wire [22:0] fraction_to_be_shifted;

    swap SWAP (fraction_a, fraction_b, sign_d, fraction_larger, fraction_to_be_shifted);

    r_shifter SHRED ({1'b0, fraction_to_be_shifted}, exponent_diff_abs, fraction_shifted);

    wire sticky_bit = sign_a ^ sign_b;

    assign fraction_smaller = sticky_bit ? ~fraction_shifted : fraction_shifted;

    wire ovf;

    u2_adder U2A (fraction_larger, fraction_smaller, sticky_bit, fraction_preout, ovf);

    assign fraction_abs = fraction_preout[23] ? -fraction_preout : fraction_preout;

    wire [22:0] fraction_out = ovf ? fraction_abs[23:1] : fraction_abs[22:0];

    wire [7:0] exponent_out = ovf ? exponent_larger + 1 : exponent_larger;

    wire sign_out = (sign_d ? sign_b : sign_a) ^ fraction_preout[23] ^ ovf;

    always @(*) begin
        out = {sign_out, exponent_out, fraction_out};
    end

endmodule
