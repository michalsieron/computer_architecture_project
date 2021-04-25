module u2_adder (
    input [23:0] in_a,
    input [23:0] in_b,
    input carry_in,
    output [23:0] out_sum
);

    assign out_sum = in_a + in_b + carry_in;

endmodule
