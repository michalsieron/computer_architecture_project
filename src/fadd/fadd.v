`include "sub8.v"
`include "mux.v"
`include "swap.v"
`include "r_shifter.v"
`include "u2_adder.v"

module fadd (
    input [31:0] a,
    input [31:0] b,
    output reg [31:0] out
);

    // setup a
    wire sign_a = a[31];
    wire [7:0] exponent_a = a[30:23];
    wire [23:0] fraction_a = |exponent_a ? {1'b1, a[22:0]} : 24'b0; 

    // setup b
    wire sign_b = b[31];
    wire [7:0] exponent_b = b[30:23];
    wire [23:0] fraction_b = |exponent_b ? {1'b1, b[22:0]} : 24'b0;

    // exponent difference
    wire [8:0] exponent_diff;
    wire [7:0] exponent_diff_abs, exponent_larger;

    sub8 ED (exponent_a, exponent_b, exponent_diff);

    wire sign_d = exponent_diff[8];

    mux MUX (exponent_a, exponent_b, sign_d, exponent_larger);

    assign exponent_diff_abs = sign_d ? -exponent_diff : exponent_diff;

    // fraction calculation
    wire [48:0] fraction_larger, fraction_shifted, fraction_smaller, fraction_sum, 
                fraction_sum_abs, fraction_preshift, fraction_prenorm;

    swap SWAP (fraction_a, fraction_b, sign_d, fraction_larger, fraction_preshift);

    r_shifter SHRED (fraction_preshift, exponent_diff_abs, fraction_shifted);

    wire different_signs = sign_a ^ sign_b;

    // conditional invert
    assign fraction_smaller = different_signs ? ~fraction_shifted : fraction_shifted;

    // U2 adder with different_signs as carry in
    wire ovf;
    u2_adder U2A (fraction_larger, fraction_smaller, different_signs, fraction_sum, ovf);

    // calculate abolute value of fraction_sum
    assign fraction_sum_abs = (fraction_sum[48] & different_signs) ? -fraction_sum : fraction_sum;

    // shift right 1 bit
    r_shifter R1SHIFT (fraction_sum_abs, {7'b0, ovf}, fraction_prenorm);

    wire [7:0] exponent_prenorm = exponent_larger + ovf;

    // calculate sign
    wire sign_out = (sign_d ? sign_b : sign_a) ^ fraction_sum[48] ^ ovf;

    // normalise result
    integer index;
    reg [47:0] fraction_out;
    reg [7:0] exponent_out;

    always @(*) begin

        fraction_out = fraction_prenorm[47:0];
        exponent_out = exponent_prenorm;
        if (different_signs) begin
            for (index = 22; index >= 0; index--) begin
                if (fraction_out[47] == 0) begin
                    fraction_out = fraction_out << 1;
                    exponent_out = exponent_out - 1;
                end
            end
        end

        out = {sign_out, exponent_out, fraction_out[46:24]};
    end

endmodule
