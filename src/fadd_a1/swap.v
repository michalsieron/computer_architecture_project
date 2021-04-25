module swap (
    input [22:0] frac_a,
    input [22:0] frac_b,
    input select,
    output [23:0] frac_larger,
    output [22:0] frac_smaller
);

    assign {frac_larger, frac_smaller} = select ? {1'b0, frac_b, frac_a} : {1'b0, frac_a, frac_b};

endmodule
