class base_test extends uvm_test; 
   `uvm_component_utils(base_test)

   env my_env; 

   virtual tinyalu_if bfm ; 

   function new(string name, uvm_component parent); 
      super.new(name, parent); 
   endfunction 

   function void build_phase(uvm_phase phase); 
      super.build_phase(phase); 
      my_env = env ::type_id :: create("My env", this); 

      // lay interface de reset dut 
      if(!uvm_config_db #(virtual tinyalu_if)::get(this, "", "bfm", bfm))
         `uvm_fatal("TEST", "Khong tim thay BFM"); 
   endfunction 

   task run_phase(uvm_phase phase); 
      random_sequence seq; 
      // bao cho UVM biet : dang ban, dung dung mo phong 
      phase.raise_objection(this); 

      //1. Reset DUT 
      bfm.reset_alu(); 
      // 2. Chay sequence 
      seq = random_sequence::type_id ::create("Seq"); 
      seq.start(my_env.agt.sqr); 
      // doi them 1 chut cho tin hieu on dinh 
      // drop objection : "xong roi, co the dugn"
      #100; 
      phase.drop_objection(this); 
   endtask 
endclass: base_test 
