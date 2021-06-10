module sub8 (
    input [7:0] a,
    input [7:0] b,
    output [8:0] diff
);

    assign diff = a - b;

endmodule
