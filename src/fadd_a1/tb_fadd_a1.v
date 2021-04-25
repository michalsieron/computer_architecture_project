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

    // test_case(32'h4AA4_0000, 32'h49CD_0000, 32'h4AD7_D081);
    // test_case(32'hC9D5_32B0, 32'h0000_0000, 32'hC9D5_32B0);
    // test_case(32'h3FC0_0000, 32'h3FC0_0000, 32'h4040_0000);
    // test_case(32'h4A36_00CA, 32'hC93C_97A8, 32'h4A06_DAE0);
    // test_case(32'h498A_D804, 32'hCA1E_F022, 32'hC9B3_0840);
    // test_case(32'hC9D5_32B0, 32'h490C_91C1, 32'hC98E_E9D0);

// test_case(32'h49d4_9bd7, 32'h48c3_3118, 32'h49e5_681d);
// test_case(32'h48ca_99a4, 32'h49da_6e66, 32'h49ed_14cf);
// test_case(32'h4a62_8d51, 32'hc9e7_ad66, 32'h49dd_6d3c);
// test_case(32'h4a63_ed63, 32'h49fd_acd8, 32'h4ad1_61e7);
// test_case(32'h4a7c_03de, 32'hc948_6d65, 32'h4a69_e885);
// test_case(32'h4a57_7d4b, 32'hcae7_336a, 32'hca76_e989);
// test_case(32'h4876_6a72, 32'h49da_7265, 32'h49e9_3fb3);
// test_case(32'h49e6_6679, 32'h49dc_49f1, 32'h4a61_5835);
// test_case(32'hc9c4_e696, 32'hcaeb_cca2, 32'hcafd_0647);
// test_case(32'h4a70_7636, 32'hcac0_9bf5, 32'hc943_06d0);
// test_case(32'h4ac4_99e5, 32'h49fb_812d, 32'h4ae3_7a30);
// test_case(32'hcadc_d28b, 32'h47d7_2a80, 32'hcadb_75e1);
// test_case(32'hc8de_d572, 32'h4a6d_3c74, 32'h4a61_61c6);
// test_case(32'hc861_5df2, 32'hc961_c355, 32'hc97a_1ad1);
test_case(32'h4a40_7241, 32'hca5d_d331, 32'hc975_83c0);
// test_case(32'h474e_6411, 32'h49d3_f021, 32'h49d6_6341);
// test_case(32'hc942_64b7, 32'hc962_7007, 32'hc9d2_6a5f);
// test_case(32'hc9e2_abbb, 32'h49f7_aeb5, 32'h48d4_0be8);
// test_case(32'h49d4_5dbf, 32'h4a78_f819, 32'h4ad1_937c);
// test_case(32'h49ec_237b, 32'h45c1_ba90, 32'h49ec_6535);
// test_case(32'hc8cd_a858, 32'h49eb_2057, 32'h49d7_b641);
// test_case(32'hc9df_a868, 32'h47d3_e893, 32'hc9da_69df);
// test_case(32'hc8c3_5401, 32'hca41_1b0d, 32'hca49_858d);
// test_case(32'hc9c8_6b2c, 32'h49d8_5aad, 32'h487f_7c08);
// test_case(32'hcac3_cca1, 32'h4ac0_007a, 32'hc879_84e0);
// test_case(32'h47ee_1fb5, 32'h49ca_79ab, 32'h49d1_5ba6);
// test_case(32'hc8c8_37e8, 32'h4a61_ed72, 32'h4a58_e675);
// test_case(32'hc958_d4c0, 32'h4a50_76d0, 32'h49f4_8340);
// test_case(32'hc7de_eed9, 32'hca5d_d446, 32'hca60_cbbd);
// test_case(32'h4a7c_327c, 32'h4a65_eddd, 32'h4af1_102c);
// test_case(32'h4942_7fef, 32'h49ef_dd13, 32'h4a48_8e85);
// test_case(32'hc7d4_4547, 32'h4a70_3664, 32'h4a6d_943a);
// test_case(32'h46d4_c0e7, 32'hca4f_1ace, 32'hca4e_714c);
// test_case(32'h49cf_5ef3, 32'h4942_f18a, 32'h49f0_d7b8);
// test_case(32'h477e_3e56, 32'hcae3_2a32, 32'hcae2_2db5);
// test_case(32'h4ac7_1117, 32'h4858_d673, 32'h4ac9_d7ca);
// test_case(32'h4a63_2a71, 32'h4a57_2913, 32'h4add_29c2);
// test_case(32'hc9e1_1161, 32'h4954_e237, 32'hc96d_408b);
// test_case(32'hc7e4_ad38, 32'hc953_659b, 32'hc95f_fb42);
// test_case(32'h48f4_0168, 32'h4aed_2cd0, 32'h4af4_6ce6);
// test_case(32'h49c8_9c90, 32'hc8d3_cd57, 32'h4967_5274);
// test_case(32'h4872_0a8a, 32'hc8de_5340, 32'hc84a_9bf6);
// test_case(32'hca59_4f91, 32'hc9d0_bb36, 32'hcac0_d696);
// test_case(32'hcad5_db92, 32'hcacf_3c68, 32'hcb52_8bfd);
// test_case(32'h49c6_ca66, 32'h48ce_8d2d, 32'h49da_6db1);
// test_case(32'hc9c4_e0e5, 32'hc8e0_1cbc, 32'hc9dc_e814);
// test_case(32'h4875_4f88, 32'hc9fa_9fb5, 32'hc9eb_f5c4);
// test_case(32'hc8e8_d67f, 32'h486b_86fa, 32'hc866_2604);
// test_case(32'hcaef_5bb5, 32'hca6a_3692, 32'hcb52_3b7f);
// test_case(32'h4a7d_13a6, 32'h46dd_b595, 32'h4a7d_cf11);

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
