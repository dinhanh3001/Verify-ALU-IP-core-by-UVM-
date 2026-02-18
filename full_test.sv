class full_test extends base_test ; 
   `uvm_component_utils(full_test)
   function new(string name, uvm_component parent); 
      super.new(name, parent); 
   endfunction 

   task run_phase(uvm_phase phase); 
      random_sequence seq_rnd; 
      max_sequence seq_max; 
      zero_sequence seq_zero; 

      phase.raise_objection(this); 

      //1. Reset DUT (dung virtual interface tu class cha base_test)
      bfm.reset_alu(); 

      //2. Chay random (10 lan)

      `uvm_info("TEST", "===== BAT DAU RANDOM TEST =====", UVM_NONE)
      seq_rnd = random_sequence::type_id::create("seq_rnd"); 
      seq_rnd .start(my_env.agt.sqr); 

      //3. Chay corner case max 
      `uvm_info("TEST","=== BAT DAU MAX VALUE TEST ===", UVM_NONE)
      seq_max = max_sequence::type_id::create("seq_max"); 
      seq_max.start(my_env.agt.sqr); 

      //4. Chay coner case zero 
      `uvm_info("TEST", "=== BAT DAU ZERO VALUE TEST ===", UVM_NONE)
      seq_zero = zero_sequence::type_id::create("seq_zero");
      seq_zero.start(my_env.agt.sqr); 

      #100ns; 
      phase.drop_objection(this); 
   endtask 
endclass: full_test 
