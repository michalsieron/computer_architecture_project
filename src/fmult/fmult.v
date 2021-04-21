module fmult
(
    input [31:0] a,
    input [31:0] b,
    output reg[31:0] out
);

    // Calculating sign of the result
    wire sign_out = a[31] ^ b[31];

    // TODO: check if normalized
    // Fraction parts of inputs
    wire [23:0] fraction_a = {1'b1, a[22:0]};
    wire [23:0] fraction_b = {1'b1, b[22:0]};

    // Calculating fractions product with width is 2 * fraction width
    wire [47:0] fraction_product = fraction_a * fraction_b;

    // If product result was of form 1X.XXXX...
    wire norm = fraction_product[47];

    // Normalising fraction of the result
    wire [22:0] fraction_out = norm ? fraction_product[46:24] : fraction_product[45:23];

    // Calculating exponent of the result from adding two input
    // exponents, subtracting bias and adding norm bit
    wire [7:0] exponent_out = a[30:23] + b[30:23] - 8'd127 + norm;

    always @(*) begin
        if ((&a[30:23] && |a[22:0]) || (&b[30:23] && |b[22:0])) begin // exp is 1s and fraction has at leats one 1
            // NaN
            out <= 32'h7FC00000;
        end else if (&a[30:23] || &b[30:23]) begin // exp is 1s
            // ±infinity
            out <= {sign_out, 31'h7F800000};
        end else if (a == 32'd0 || b == 32'd0) begin
            // a or b is 0
            out <= 32'd0;
        end else begin
            // normal result
            out <= {sign_out, exponent_out, fraction_out};
        end
    end

endmodule