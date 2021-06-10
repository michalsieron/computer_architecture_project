module fmult_denorm
(
    input [31:0] a,
    input [31:0] b,
    output reg[31:0] out
);
    // Sign of a and b
    wire sign_a, sign_b;

    // Exponent of a and b
    wire [7:0] exponent_a, exponent_b;

    // Fraction parts of inputs a and b
    wire [22:0] fraction_a, fraction_b;
    
    // Variable assignment
    assign {sign_a, exponent_a, fraction_a} = a;
    assign {sign_b, exponent_b, fraction_b} = b;
    
    // Calculating sign
    wire sign_out = sign_a ^ sign_b;

    // Multiplier of 2 fraction
    wire [47:0] fraction_product = fraction_a * fraction_b;
    wire [22:0] fraction_out = fraction_product[46:24];
    
    // Calculating exponent
    wire [8:0] exponent_out = exponent_a + exponent_b - 8'd127 + 1'd1;

    always @(*) begin
        if (a == 32'd0 || b == 32'd0) begin
            // a or b is 0
            out = 32'd0;
        end else if (exponent_out[8] == 1) begin
            out = 32'd0;
        end else begin
            // normal result
            out = {sign_out, exponent_out[7:0], fraction_out};
        end
    end

endmodule
