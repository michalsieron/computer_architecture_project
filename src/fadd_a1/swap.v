module swap (
    input [22:0] a,
    input [22:0] b,
    input select,
    output [23:0] swapped_a,
    output [23:0] swapped_b
);

    assign swapped_a = {1'b0, select ? b : a};
    assign swapped_b = {1'b0, select ? a : b};

endmodule
