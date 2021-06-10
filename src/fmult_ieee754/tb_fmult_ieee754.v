`timescale 1ps/1ps

`include "fmult_ieee754.v"

module tb_fmult_ieee754;

reg [31:0] a, b;
wire [31:0] out;

reg clk = 1'b1;

fmult_ieee754 uut(a, b, out);

always clk = #5 ~clk;

initial begin

	$dumpfile("fmult_out.vcd");
	$dumpvars(0, tb_fmult_ieee754);

    test_case(32'h0200_0000, 32'h0200_0000, 32'h0000_0000);
    test_case(32'h4234_851F, 32'h427C_851F, 32'h4532_10E9); // 45.13 * 63.13 = 2849.0569;
    test_case(32'h4049_999A, 32'hC166_3D71, 32'hC235_5062); //3.15 * -14.39 = -45.3285
    test_case(32'hC152_6666, 32'hC240_A3D7, 32'h441E_5374); //-13.15 * -48.16 = 633.304
    test_case(32'h4580_0000, 32'h4580_0000, 32'h4B80_0000); //4096 * 4096 = 16777216
    test_case(32'h3ACA_62C1, 32'h3ACA_62C1, 32'h361F_FFFF); //0.00154408081 * 0.00154408081 = 0.00000238418
    test_case(32'h0000_0000, 32'h0000_0000, 32'h0000_0000); // 0 * 0 = 0;
    test_case(32'hC152_6666, 32'h0000_0000, 32'h0000_0000); //-13.15 * 0 = 0;
    test_case(32'h7F80_0000, 32'h7F80_0000, 32'h7F80_0000); // inf * inf = inf
    test_case(32'h7F80_0000, 32'hFF80_0000, 32'hFF80_0000); // -inf * inf = -inf
    test_case(32'hFF80_0000, 32'h7F80_0000, 32'hFF80_0000); // inf * -inf = -inf
    test_case(32'hFF80_0000, 32'hFF80_0000, 32'h7F80_0000); // -inf * -inf = inf
    test_case(32'h7F80_0000, 32'h7F80_000D, 32'h7FC0_0000); // inf * NaN = NaN

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
            $display("Success: %h * %h = %h", a_in, b_in, out);
        else
            $display("Error:   %h * %h = %h | %h", a_in, b_in, out, expected_out);
    end
end
endtask

endmodule