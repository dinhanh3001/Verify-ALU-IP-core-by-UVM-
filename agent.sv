/*import uvm_pkg::*;
import tinyalu_pkg::*;
class agent extends uvm_agent; 
   `uvm_component_utils(agent)

   driver drv; 
   uvm_sequencer #(command_transaction) sqr; 
   monitor mon ; 
   // cong ra cua agent (noi thong tu monitor ra ngoai)
   uvm_analysis_port #(command_transaction)ap; 
   function new(string name, uvm_component parent); 
      super.new(name, parent); 
   endfunction 

   function void build_phase(uvm_phase phase); 
      super.build_phase(phase);
      // xay dung monitor (luon can thiet)
      mon = monitor ::type_id :: create ("mon", this); 

      // chi xay dung drier /sequencer neu agent dang o che do active 
      // neu agen chi dung de nghe len (passive) , ta khong can driver 

      if(get_is_active() == UVM_ACTIVE)begin 
        drv = driver::type_id::create("DRV", this); 
        sqr = uvm_sequencer #(command_transaction)::type_id ::create("SQR", this); 
      end 
   endfunction 

   function void connect_phase(uvm_phase phase); 
     // noi driver voi sequencer 
     if(get_is_active()==UVM_ACTIVE)begin 
        drv.seq_item_port.connect(sqr.seq_item_export); 
     end 
     // noi cong monitor ra cong agent de enviroment dung 
     ap= mon.ap; 
   endfunction 
endclass: agent 
*/ 
import uvm_pkg::*;
import tinyalu_pkg::*;

class agent extends uvm_agent; // 
   `uvm_component_utils(agent)

   driver drv; 
   uvm_sequencer #(command_transaction) sqr; 
   monitor mon; 
   uvm_analysis_port #(command_transaction) ap; 

   function new(string name, uvm_component parent); 
      super.new(name, parent); 
   endfunction 

   function void build_phase(uvm_phase phase); 
      super.build_phase(phase);
      ap = new("ap", this);
      mon = monitor::type_id::create("mon", this); 

      if(get_is_active() == UVM_ACTIVE) begin 
        drv = driver::type_id::create("DRV", this); 
        sqr = uvm_sequencer#(command_transaction)::type_id::create("SQR", this); 
      end 
   endfunction 

   function void connect_phase(uvm_phase phase); 
     if(get_is_active() == UVM_ACTIVE) begin 
        drv.seq_item_port.connect(sqr.seq_item_export); 
     end 
     // SỬA: Dùng hàm connect()
     mon.ap.connect(this.ap); 
   endfunction 
endclass: agent