import uvm_pkg::*;
import tinyalu_pkg::*;
// sinh ra cac command_transaction 
class random_sequence extends uvm_sequence #(command_transaction); 
   `uvm_object_utils(random_sequence)
   function new(string name="random_sequence"); 
      super.new(name); 
   endfunction 

   // body la noi chay kich ban chinh 

   task body(); 
      command_transaction cmd; 

      repeat(100)begin 
      //1. Khoi tao object 
      cmd = command_transaction :: type_id :: create("cmd"); 
      // bat tay voi driver 

      start_item(cmd); 

      //3. Randomize (sau khi start_item de ho tro late_randomization neu can)
      if(!cmd.randomize()) `uvm_error("RND", "Randomize failed");

      //4. Gui sang driver 
      finish_item(cmd); 
      // log ket qua tra ve tu DUT (do driver dien vao)
      `uvm_info("SEQ", $sformatf("Xong lenh: %s", cmd.convert2string()), UVM_MEDIUM)
      end 
   endtask 
endclass : random_sequence 

