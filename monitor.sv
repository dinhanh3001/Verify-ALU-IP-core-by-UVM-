import uvm_pkg::*;
import tinyalu_pkg::*;
class monitor extends uvm_monitor; 
   `uvm_component_utils (monitor) 

   virtual tinyalu_if bfm; 

   // cong phan tich (analysis port) dung de gui du lieu di (broadcast)
   // khac voi seq_item_port (keo/tha), cong nay giong nhu dai phat thanh (1 nguoi noi, nhieu nguoi nghe)
   uvm_analysis_port #(command_transaction) ap; 

   function new(string name, uvm_component parent); 
      super.new(name, parent); 
      ap = new("ap", this); 
   endfunction 
   function void build_phase(uvm_phase phase); 
      if(!uvm_config_db #(virtual tinyalu_if) ::get (this, "", "bfm", bfm))
      `uvm_fatal("MON", "KHONG TIM THAY BFM"); 
   endfunction 

   task run_phase(uvm_phase phase); 
      command_transaction cmd; 
      forever begin 
        cmd = new(); 
        // goi BFM de lay du lieu tu bus 

        bfm.monitor_alu(cmd.A, cmd.B, cmd.op, cmd.result); 

        // in ra log de bit monitor dang hoat dong 
        `uvm_info("MON", $sformatf("Thay giao dich: %s", cmd.convert2string()), UVM_MEDIUM); 

        // phat du lieu cho scoreboard hoac coverage 
        ap.write(cmd); 
      end 
   endtask 
endclass:monitor 
