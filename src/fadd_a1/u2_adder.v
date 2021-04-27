module u2_adder (
    input [23:0] in_a,
    input [23:0] in_b,
    input carry_in,
    output [23:0] out_sum,
    output ovf
);

    wire extra;

    assign {extra, out_sum} = {in_a[23], in_a} + {in_b[23], in_b} + carry_in;
    assign ovf = extra ^ out_sum[23];

endmodule
