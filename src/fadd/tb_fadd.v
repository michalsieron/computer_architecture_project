`timescale 1ps/1ps

`include "fadd.v"

module fadd_tb;

reg [31:0] a, b;
wire [31:0] out;

reg clk = 1'b1;

fadd uut(a, b, out);

always clk = #5 ~clk;

initial begin

	$dumpfile("fadd_out.vcd");
	$dumpvars(0, fadd_tb);

    test_case(32'h3F80_0000, 32'h0000_0000, 32'h3F80_0000); // 1 + 0 = 1
    test_case(32'h0200_0000, 32'h0200_0000, 32'h2800_0000); // 
    test_case(32'h4234_851F, 32'h427C_851F, 32'h42D8_851F); // 45.13 + 63.13 = 108.26
    test_case(32'h4049_999A, 32'hC166_3D71, 32'hC133_D70A); // 3.15 - 14.39 = -11.24
    test_case(32'hC152_6666, 32'hC240_A3D7, 32'hC275_3D70); // -13.15 - 48.16 = -61.309999999999995
    test_case(32'h4580_0000, 32'h4580_0000, 32'h4600_0000); // 4096 + 4096
    test_case(32'h3ACA_62C1, 32'h3ACA_62C1, 32'h3B4A_62C1); // 0.00154408081 + 0.00154408081
    test_case(32'h0000_0000, 32'h0000_0000, 32'h0000_0000); // 0 + 0 = 0
    test_case(32'hC152_6666, 32'h0000_0000, 32'hC152_6666); // -13.15 + 0 = -13.15
    test_case(32'h7F80_0000, 32'h7F80_0000, 32'h7F80_0000); // inf + inf = inf
    test_case(32'h7F80_0000, 32'hFF80_0000, 32'hFFC0_0000); // -inf + inf = NaN
    test_case(32'hFF80_0000, 32'h7F80_0000, 32'hFFC0_0000); // inf - inf = NaN
    test_case(32'hFF80_0000, 32'hFF80_0000, 32'hFF80_0000); // -inf - inf = -inf
    test_case(32'h7F80_0000, 32'h7F80_000D, 32'h7FC0_000D); // inf + NaN = NaN

    $finish;
end

task test_case(
    input [31:0] a_in,
    input [31:0] b_in,
    input [31:0] expected_out
); begin
    @(negedge clk) begin
        a = a_in;
        b = b_in;
    end
    @(posedge clk) begin
        if (expected_out == out)
            $display("Success: %h + %h = %h", a_in, b_in, out);
        else
            $display("Error:   %h + %h = %h | %h", a_in, b_in, out, expected_out);
    end
end
endtask

endmodule