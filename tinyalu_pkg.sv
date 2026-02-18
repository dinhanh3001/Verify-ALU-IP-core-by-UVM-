/*package tinyalu_pkg;
// import thu vien UVM 
import uvm_pkg ::*; 
`include "uvm_macros.svh"

    typedef enum bit [2:0] {
        NO_OP  = 3'b000,
        ADD_OP = 3'b001,
        AND_OP = 3'b010,
        XOR_OP = 3'b011,
        MUL_OP = 3'b100,
        RST_OP = 3'b111 // Dùng cho testbench, DUT không dùng cái này
    } operation_t;
`include "command_transaction.sv"
`include "random_sequence.sv"
`include "monitor.sv"     
`include "driver.sv"
`include "agent.sv"       
`include "scoreboard.sv"  
`include "env.sv"
`include "base_test.sv"      
endpackage : tinyalu_pkg
*/ 

package tinyalu_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    typedef enum bit [2:0] {
        NO_OP  = 3'b000,
        ADD_OP = 3'b001,
        AND_OP = 3'b010,
        XOR_OP = 3'b011,
        MUL_OP = 3'b100,
        RST_OP = 3'b111 
    } operation_t;

    `include "command_transaction.sv"
    `include "corner_sequence.sv"
endpackage : tinyalu_pkg