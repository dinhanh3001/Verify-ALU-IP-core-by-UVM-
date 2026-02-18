
/*class env extends uvm_env; 
   `uvm_component_utils (env) 

   driver drv; 
   uvm_sequence #(command_transaction)sqr; // sequencer co san cua UVM 

   function new(string name, uvm_component parent); 
      super.new(name,parent); 
   endfunction 

   function void build_phase(uvm_phase phase); 
      super.build_phase(phase); 
      // tao cac thanh phan con 
      drv = driver:: type_id::create("DRV",this); 
      sqr = uvm_sequencer#(command_transaction)::type_id::create("sqr", this); 
   endfunction 

   function void connect_phase(uvm_phase phase); 
      // noi dau vao cua driver vao cong dau ra cua sequencer 

      drv.seq_item_port.connect(sqr.seq_item_export); 
      agt.ap.connect(scb.analysis_expot); 
   endfunction 
endclass: env 
*/ 

import uvm_pkg::*;
import tinyalu_pkg::*;

class env extends uvm_env; 
   `uvm_component_utils(env) 

   agent      agt; 
   scoreboard scb;
   functional_coverage cov; 


   function new(string name, uvm_component parent); 
      super.new(name, parent); 
   endfunction 

   function void build_phase(uvm_phase phase); 
      super.build_phase(phase);
      agt = agent::type_id::create("agt", this);
      scb = scoreboard::type_id::create("scb", this);
      cov = functional_coverage::type_id::create("cov", this); 

   endfunction 

   function void connect_phase(uvm_phase phase); 
      agt.ap.connect(scb.analysis_export); 
      // noi monitor  ra coverage 
      agt.ap.connect(cov.analysis_export); 
   endfunction 
endclass: env