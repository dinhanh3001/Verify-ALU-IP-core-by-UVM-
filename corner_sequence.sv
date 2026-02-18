//1. Sequence chuyen test gia tri MAX (corner case: 0xff)
class max_sequence extends uvm_sequence #(command_transaction); 
   `uvm_object_utils(max_sequence)

   function new(string name = "max_sequence"); 
      super.new(name); 
   endfunction 

   task body(); 
      command_transaction cmd; 
      // chay 5 lan phep nhan so to nhat de xem ket qua co bi tran bit khong 
      repeat(5) begin 
        cmd = command_transaction ::type_id::create("cmd"); 
        start_item(cmd); 
        // Ky thuat inline constraint 
        // randomize nhung ep buoc A va B phai la FF 
        if(!cmd.randomize() with{
            A == 8'hFF; 
            B == 8'hFF; 
            op == MUL_OP; 

        }) `uvm_error("SEQ", "Randomize failed"); 

        finish_item(cmd); 
        `uvm_info("MAX_SEQ", $sformatf("Gui lenh MAX: %s", cmd.convert2string()), UVM_MEDIUM)
      end 
   endtask 
endclass:max_sequence 

//2. Sequence chuyen test cac gia tri 0( corner case : zero)

class zero_sequence extends uvm_sequence #(command_transaction); 
   `uvm_object_utils(zero_sequence)

   function new(string name ="zero_sequence"); 
      super.new(name);
   endfunction 

   task body(); 
      command_transaction cmd; 
      repeat(5) begin 
        cmd = command_transaction ::type_id:: create("cmd");
        start_item(cmd);  
        // Ep buoc A hoac B bang 0 
        if(!cmd.randomize()with {
            A == 0 || B == 0; 
            op inside {ADD_OP, MUL_OP}; 
        })`uvm_error("SEQ", "Randomize failed"); 
        finish_item(cmd); 
      end 
   endtask 
endclass: zero_sequence 
