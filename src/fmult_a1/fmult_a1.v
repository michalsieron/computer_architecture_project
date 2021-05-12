module fmult_a1
(
    input [31:0] a,
    input [31:0] b,
    output reg[31:0] out
);
    // Sign of a and b
    wire sign_a, sign_b;

    // Calculating sign
    wire sign_out = a[31] ^ b[31];

    // Fraction parts of inputs a and b
    wire [23:0] fraction_a, fraction_b

    // Exponent of a and b
    wire [7:0] exponent_a, exponent_b;
    
    // Variable assignment
    assign {sign_a, exponent_a, fraction_a} = a;
    assign {sign_b, exponent_b, fraction_b} = b;

    //Multiplier of 2 fraction
    wire [47:0] fraction_product = fraction_a * fraction_b;
    wire [22:0] fraction_out = fraction_product[46:24]

    wire [7:0] exponent_product = fraction_a + fraction_b + 1;

    always @(*) begin
        out <= {sign_out, exponent_product, fraction_out};
    end

endmodule