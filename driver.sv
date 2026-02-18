// driver ke thua tu uvm_driver va chi dinh ro no lai loai transaction nao 
import tinyalu_pkg::*;
import uvm_pkg::*;
class driver extends uvm_driver #(command_transaction); 
   `uvm_component_utils(driver); 

   //1. Khai bao virtual interface 
   // day la cac class cham vao phan cung 
   virtual tinyalu_if bfm; 
   //2. Constructor 
   function new(string name, uvm_component parent); 
      super.new(name, parent); 
   endfunction: new 

   //3. Build phase ( giai doan chuan bi)
   // lay handle cua interface tu database 
   function void build_phase(uvm_phase phase); 
      super.build_phase(phase); 
      if(!uvm_config_db #(virtual tinyalu_if) :: get(this, "", "bfm", bfm))begin 
         `uvm_fatal("NO_IF", "DRIVER khong tim that virutal interface 'bfm' trong DB"); 
      end 
   endfunction: build_phase 
   //4. Run phase (giai doan chay chinh)
   task run_phase(uvm_phase phase); 
      // bien chua transaction 
      command_transaction cmd; 

      forever begin 
        //a. Lay transaction tiep theo tu sequencer 
        // dong nay se treo cho den khi co hang 
        seq_item_port.get_next_item(cmd); 

        //b. In log bao cao (thay cho display)
        `uvm_info("DRV", $sformatf("Dang lai transaction: %s", cmd.convert2string()), UVM_MEDIUM); 
        // lai tin hieu 
        bfm.send_op(cmd.A, cmd.B, cmd.op, cmd.result); 

        // bao cao da xong  viec 
        seq_item_port.item_done(); 
      end 
   endtask :run_phase 
endclass:driver 
