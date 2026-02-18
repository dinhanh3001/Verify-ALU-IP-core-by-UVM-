import uvm_pkg::*;
import tinyalu_pkg::*;
// ke thua uvm_subscriber: tu dongco ham write de nhan du lieu tu annalsis_port 
class scoreboard extends uvm_subscriber #(command_transaction); 
   `uvm_component_utils (scoreboard) 
   function new(string name, uvm_component parent); 
      super.new(name,parent); 
   endfunction 

   // ham write se tu dong duoc goi khi monitor phat song (ap.write)

   function void write(command_transaction t); 
      shortint expected; 
      bit error = 0; 

      //1. Mo hinh tham chieu - tinh ket qua dung 
      case(t.op)
         ADD_OP: expected = t.A + t.B; 
         AND_OP: expected = t.A & t.B; 
         XOR_OP: expected = t.A ^ t.B; 
         MUL_OP: expected = t.A * t.B; 
         NO_OP : expected = 0; 
         default: expected = 0; 
      endcase 

      //2. So sanh 

      if(t.op!= NO_OP && t.op !=RST_OP)begin
        if(expected !==t.result)begin 
            `uvm_error("SCB", $sformatf("SAI ROI! A: %0d, B: %0d, Op: %s. DUT ra: %0d, Dung la: %0d", 
                                        t.A, t.B, t.op.name(), t.result, expected)) ; 
        end 
        else begin 
            `uvm_info("SCB", $sformatf("DUNG: %s", t.convert2string()), UVM_MEDIUM)
         end
      end 
   endfunction 
endclass :scoreboard 
