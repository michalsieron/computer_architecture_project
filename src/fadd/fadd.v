module fadd
(
    input [31:0] a,
    input [31:0] b,
    output reg[31:0] out
);

// setup a
wire sign_a = a[31];
wire [7:0] exponent_a = a[30:23];
wire [24:0] fraction_a = |exponent_a ? {2'b01, a[22:0]} : 25'b0; // TODO: don't treat denormalized numbers as 0

// setup b
wire sign_b = b[31];
wire [7:0] exponent_b = b[30:23];
wire [24:0] fraction_b = |exponent_b ? {2'b01, b[22:0]} : 25'b0; // TODO: don't treat denormalized numbers as 0

// small alu
wire [7:0] exponent_diff = exponent_a - exponent_b;

// select signal mux
wire select = a[30:0] < b[30:0];

wire [7:0] exponent_diff_abs = exponent_diff[7] ? -exponent_diff : exponent_diff;

// fraction muxes
wire [48:0] fraction_larger = {select ? fraction_b : fraction_a, 24'b0};
wire [48:0] fraction_tmp = {select ? fraction_a : fraction_b, 24'b0};

// fraction shift right
wire [48:0] fraction_smaller = fraction_tmp >> exponent_diff_abs;

// sign muxes
wire sign_larger = select ? sign_b : sign_a;

// big alu
wire [48:0] fraction_prenorm = sign_a ^ sign_b ? fraction_larger - fraction_smaller : fraction_larger + fraction_smaller;

// exponent mux
wire [7:0] exponent_larger = select ? exponent_b : exponent_a;

// normalise block
integer index;
reg [48:0] fraction_postnorm;
reg [7:0] exponent_postnorm;

always @(*) begin

    fraction_postnorm = fraction_prenorm;
    exponent_postnorm = exponent_larger;
    if (sign_a ^ sign_b) begin
        for (index = 22; index >= 0; index--) begin
            if (fraction_postnorm[47] == 0) begin
                fraction_postnorm = fraction_postnorm << 1;
                exponent_postnorm = exponent_postnorm - 1;
            end
        end
    end else begin
        if (fraction_prenorm[48]) begin
            fraction_postnorm = fraction_prenorm >> 1;
            exponent_postnorm = exponent_larger + 1;
        end else begin
            fraction_postnorm = fraction_prenorm;
            exponent_postnorm = exponent_larger;
        end
    end

// exception checking
    
    // if ((&a[30:23] && |a[22:0]) || (&b[30:23] && |b[22:0])) begin // exp is 1s and fraction has at least one 1
    //     // NaN
    //     out = 32'h7FC00000;
    // end else if ((&a[30:23] || &b[30:23]) && a[31] == b[31]) begin // exp is 1s
    //     // ±∞
    //     out = {a[31], 31'h7F800000};
    // end else if ((&a[30:23] || &b[30:23]) && a[31] != b[31]) begin // ∞ - ∞
    //     // NaN
    //     out = 32'h7FC00000;
    // end else if (&exponent_postnorm) begin
    //     out = {sign_larger, 8'hFF, 23'h0};
    // end else

// rounding
    if (fraction_postnorm[23] & |fraction_postnorm[22:0]) begin
        fraction_postnorm[48:24] = fraction_postnorm[48:24] + 1;
    end else if (&fraction_postnorm[24:23] & !(|fraction_postnorm[22:0])) begin
        fraction_postnorm[48:24] = fraction_postnorm[48:24] + 1;
    end

    if (exponent_postnorm == 8'd0) begin
        out = 32'h0;
    end else begin
        out = {sign_larger, exponent_postnorm, fraction_postnorm[46:24]};
    end
end

endmodule
