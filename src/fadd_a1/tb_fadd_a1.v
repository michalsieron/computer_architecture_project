`timescale 1ps/1ps

`include "fadd_a1.v"

module tb_fadd_a1;

reg [31:0] a, b;
wire [31:0] out;

reg clk = 1'b1;

fadd_a1 uut(a, b, out);

always clk = #5 ~clk;

initial begin

	$dumpfile("fadd_a1_out.vcd");
	$dumpvars(0, tb_fadd_a1);

    test_case(32'h0000_0000, 32'h0000_0000, 32'h0000_0000); // 0 + 0 = 0
    test_case(32'h0000_0000, 32'h8000_0000, 32'h0000_0000); // 0 - 0 = 0
    test_case(32'h8000_0000, 32'h0000_0000, 32'h8000_0000); // -0 + 0 = -0
    test_case(32'h3FC0_0000, 32'h0000_0000, 32'h3FC0_0000); // 1 + 0 = 1
    test_case(32'h0000_0000, 32'h3FC0_0000, 32'h3FC0_0000); // 0 + 1 = 1
    test_case(32'h8000_0000, 32'hBFC0_0000, 32'hBFC0_0000); // -0 - 1 = -1
    test_case(32'hBFC0_0000, 32'h8000_0000, 32'hBFC0_0000); // -1 - 0 = -1
    test_case(32'h7F7F_FFFF, 32'h0000_0000, 32'h7F7F_FFFF); // 3.4028234e+38 + 0 = 3.4028234e+38
    test_case(32'h0000_0000, 32'h7F7F_FFFF, 32'h7F7F_FFFF); // 0 + 3.4028234e+38 = 3.4028234e+38
    test_case(32'h7F7F_FFFF, 32'h8000_0000, 32'h7F7F_FFFF); // 3.4028234e+38 - 0 = 3.4028234e+38
    test_case(32'h0000_0000, 32'hFF7F_FFFF, 32'hFF7F_FFFF); // 0 - 3.4028234e+38 = -3.4028234e+38
    test_case(32'h3FC0_0000, 32'h7F7F_FFFF, 32'h7F7F_FFFF); // 1 + 3.4028234e+38 = 3.4028234e+38
    test_case(32'h7F7F_FFFF, 32'h3FC0_0000, 32'h7F7F_FFFF); // 3.4028234e+38 + 1 = 3.4028234e+38
    test_case(32'h7F7F_FFFF, 32'h7C7F_FFFF, 32'h7fbf_0001); // 3.4028234e+38 + 5.3169116e+36 = NaN <- overflow
    test_case(32'h7C7F_FFFF, 32'h7F7F_FFFF, 32'h7fbf_0001); // 5.3169116e+36 + 3.4028234e+38 = NaN <- overflow
    test_case(32'hFF7F_FFFF, 32'hFC7F_FFFF, 32'hFfbf_0001); // -3.4028234e+38 - 5.3169116e+36 = -NaN <- underflow
    test_case(32'hFC7F_FFFF, 32'hFF7F_FFFF, 32'hFfbf_0001); // -5.3169116e+36 - 3.4028234e+38 = -NaN <- underflow
    test_case(32'h4A02_7533, 32'h4928_FA97, 32'h4a0c_b3d8); // 80537.5 + 335698.875 = 416236
    test_case(32'h4928_FA97, 32'h4A02_7533, 32'h4a0c_b3d8); // 335698.875 + 80537.5 = 416236
    test_case(32'h4928_FA97, 32'hCA02_7533, 32'h4a07_c972); // 335698.875 - 80537.4987 = 255160.9997
    test_case(32'hCA02_7533, 32'h4928_FA97, 32'h4a07_c972); // -80537.4987 + 335698.875 = 255160.9997
    
    
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
