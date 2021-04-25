module exponent_difference (
    input [7:0] exp_a,
    input [7:0] exp_b,
    output [8:0] exp_diff
);

    assign exp_diff = exp_a - exp_b;

endmodule
