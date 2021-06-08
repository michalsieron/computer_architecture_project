module swap (
    input [23:0] a,
    input [23:0] b,
    input select,
    output [48:0] swapped_a,
    output [48:0] swapped_b
);

    assign swapped_a = {1'b0, select ? b : a, 24'b0};
    assign swapped_b = {1'b0, select ? a : b, 24'b0};

endmodule
