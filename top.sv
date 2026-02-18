// 1. Dữ liệu nền tảng
// 1. Data Types
`include "tinyalu_pkg.sv"

// 2. Interface (Cần Pkg)
`include "tinyalu_if.sv"

// 3. DUT
`include "tinyalu.sv"

// 4. Components (Theo thứ tự Tuyến tính: Con -> Cha)
`include "random_sequence.sv" // Seq cần Trans (trong Pkg)
`include "monitor.sv"         // Mon cần If và Pkg
`include "driver.sv"
`include "agent.sv"           // Agent chứa Mon + Drv
`include "scoreboard.sv"
`include "functional_coverage.sv"
`include "env.sv"             // Env chứa Agent + Scb
`include "base_test.sv"       // Test chứa Env
`include "full_test.sv"
module top;
   import uvm_pkg::*;
   import tinyalu_pkg::*;

   bit clk, reset_n;
   always #5 clk = ~clk;

   initial begin
      clk = 0; reset_n = 0;
      #20 reset_n = 1;
   end

   // 1. Interface
   tinyalu_if bfm(clk, reset_n);

   // 2. DUT
   tinyalu dut (
      .A(bfm.A), .B(bfm.B), .op(bfm.op),
      .clk(bfm.clk), .reset_n(bfm.reset_n),
      .start(bfm.start), .done(bfm.done),
      .result(bfm.result)
   );

   initial begin
      // 3. Đưa Interface vào Database
      // set(context, "path_to_component", "key_name", value)
      // null: Global scope
      // "*": Mọi component con đều nhìn thấy
      uvm_config_db #(virtual tinyalu_if)::set(null, "*", "bfm", bfm);

      // 4. Chạy Test
      // Tự động tìm class có tên "base_test" trong package để chạy
      run_test("full_test");
   end

endmodule : top