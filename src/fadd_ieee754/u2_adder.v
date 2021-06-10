module u2_adder (
    input [48:0] in_a,
    input [48:0] in_b,
    input carry_in,
    output [48:0] out_sum,
    output ovf
);

    wire extra;

    assign {extra, out_sum} = {in_a[48], in_a} + {in_b[48], in_b} + carry_in;
    assign ovf = extra ^ out_sum[48];

endmodule
