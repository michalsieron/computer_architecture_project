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

    test_case(32'h4A36_00CA, 32'hC93C_97A8, 32'h4A06_DAE0);
    test_case(32'h498A_D804, 32'hCA1E_F022, 32'hC9B3_0840);
    test_case(32'h4AA4_6873, 32'h49CD_A038, 32'h4AD7_D081);
    test_case(32'hC9D5_32B0, 32'h490C_91C1, 32'hC98E_E9D0);
    test_case(32'hC8DE_2B1B, 32'h4A47_E514, 32'h4A2C_1FB1);
    test_case(32'h4A74_30F1, 32'h499E_2E20, 32'h4AA1_A400);
    test_case(32'h4991_E4C7, 32'h4A03_8953, 32'h4A4C_7BB6);
    test_case(32'h4A16_B076, 32'hC8C6_08CB, 32'h49FB_DEB9);
    test_case(32'h4921_7B24, 32'h494E_793B, 32'h49B7_FA30);
    test_case(32'hCA86_532E, 32'h4982_FD22, 32'hCA4B_27CB);
    test_case(32'hC871_BDAC, 32'hC9B4_82ED, 32'hC9D2_BAA2);
    test_case(32'h4A9C_31FF, 32'h49DC_F026, 32'h4AD3_6E08);
    test_case(32'h47A7_5C74, 32'hC967_24C7, 32'hC952_3938);
    test_case(32'h4834_A468, 32'hC93D_0936, 32'hC90F_E01C);
    test_case(32'h4AEF_BD8E, 32'h4972_5577, 32'h4B07_041E);
    test_case(32'hC819_3965, 32'hC9A5_6F44, 32'hC9B8_9671);
    test_case(32'hC96A_3E8C, 32'h496E_F9C6, 32'h4697_6740);
    test_case(32'hC7BC_4D05, 32'h4982_8A0C, 32'h496D_8A77);
    test_case(32'hCA80_26F8, 32'h49B4_7882, 32'hCA26_11AF);
    test_case(32'h4AB5_C0E5, 32'h4AA1_2D57, 32'h4B2B_771E);
    test_case(32'hCAA5_DDEA, 32'h4984_621D, 32'hCA84_C563);
    test_case(32'hC9DA_07B3, 32'h4A05_7FD0, 32'h48C3_DFB4);
    test_case(32'h49C2_02F6, 32'h49C4_9B90, 32'h4A43_4F43);
    test_case(32'hC8E2_6BEA, 32'h4A4C_E5B7, 32'h4A30_983A);
    test_case(32'hCA64_030C, 32'h4AA2_4E26, 32'h49C1_3280);
    test_case(32'h4894_B8F8, 32'hC7FB_5EF5, 32'h482B_C276);
    test_case(32'hCAA7_3301, 32'hC925_4A8D, 32'hCABB_DC53);
    test_case(32'hC95E_8874, 32'hCA40_94B7, 32'hCA78_36D4);
    test_case(32'h4834_E5CE, 32'hCA98_BCB5, 32'hCA93_1587);
    test_case(32'hCA80_0F7F, 32'hC8BE_4DA7, 32'hCA8B_F459);
    test_case(32'hC8F1_5AEC, 32'h48B4_410E, 32'hC7F4_6778);
    test_case(32'h4A51_FA3C, 32'h4984_6E87, 32'h4A8A_18C0);
    test_case(32'h49CB_9780, 32'hC902_35B3, 32'h498A_7CA6);
    test_case(32'hCA28_C481, 32'hC98E_2183, 32'hCA6F_D542);
    test_case(32'h48F7_6BAC, 32'h49C6_F509, 32'h4A02_67FA);
    test_case(32'h4A88_09BA, 32'h49B6_D025, 32'h4AB5_BDC3);
    test_case(32'hC911_2D58, 32'h4A27_97C8, 32'h4A03_4C72);
    test_case(32'h4715_BF67, 32'h498B_4657, 32'h498F_F452);
    test_case(32'hCAB8_5186, 32'h499D_945E, 32'hCA90_EC6E);
    test_case(32'h4A4A_0537, 32'hCAD6_9663, 32'hCA63_278F);
    test_case(32'hC6AA_51EF, 32'hC9ED_E0EC, 32'hC9F0_8A34);
    test_case(32'h496C_25A9, 32'hCA8D_299A, 32'hCA5F_49CA);
    test_case(32'h4841_04FF, 32'hC910_46A7, 32'hC8C0_0ACE);
    test_case(32'h4AE5_B6B4, 32'hCA15_27FF, 32'h4A9B_22B4);
    test_case(32'hCA9A_68CA, 32'h4989_3EA4, 32'hCA70_3242);
    test_case(32'h463F_D1E1, 32'h4904_179B, 32'h4907_16E3);
    test_case(32'h4A13_673A, 32'h486E_B87C, 32'h4A22_52C2);
    test_case(32'hCA0F_7140, 32'h4863_1EB8, 32'hCA01_3F54);
    test_case(32'hC92E_1F26, 32'h4A82_43DB, 32'h4A58_FFEC);
    test_case(32'hCA39_75F3, 32'hC9C7_7708, 32'hCA8E_98BC);
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