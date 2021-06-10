module fmult_ieee754
(
    input [31:0] a,
    input [31:0] b,
    output reg[31:0] out
);

    // setup a
    wire sign_a = a[31];
    wire [7:0] exponent_a = a[30:23];
    wire [23:0] fraction_a = |exponent_a ? {1'b1, a[22:0]} : 24'b0; 

    // setup b
    wire sign_b = b[31];
    wire [7:0] exponent_b = b[30:23];
    wire [23:0] fraction_b = |exponent_b ? {1'b1, b[22:0]} : 24'b0;

    // Calculating fractions product with width is 2 * fraction width
    wire [47:0] fraction_product = fraction_a * fraction_b;

    // If product result was of form 1X.XXXX...
    wire norm = fraction_product[47];

    // Normalising fraction of the result
    wire [22:0] fraction_out = norm ? fraction_product[46:24] : fraction_product[45:23];

    // Calculating exponent of the result from adding two input
    // exponents, subtracting bias and adding norm bit
    wire [8:0] exponent_out = exponent_a + exponent_b - 8'd127 + norm; 

    // Calculating sign of the result
    wire sign_out = sign_a ^ sign_b;

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