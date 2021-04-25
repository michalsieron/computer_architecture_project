module r_shifter (
    input [23:0] to_be_shifted,
    input [7:0] amount,
    output [23:0] shifted
);

    assign shifted = to_be_shifted >> amount;

endmodule
