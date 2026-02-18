class functional_coverage extends uvm_subscriber #(command_transaction); 
   `uvm_component_utils(functional_coverage); 

   // bien cuc bo de luu transaction can sample 
   command_transaction t; 
   // KHAI BAO COVERGROUP ( BANG CHECK LIST)

   covergroup op_cov; 

      //1. Check list cho Operation (da test du cac lenh)
      cp_op: coverpoint t.op{
        // yeu cau phai xuat hien it nhat 1 lan moi loai 
        bins single_ops[]= {ADD_OP, AND_OP, XOR_OP, MUL_OP}; 
        // kHONG TINH RST_OP va NO_OP vao diem so 
        ignore_bins rst = {RST_OP, NO_OP}; 
      }

      //2. Checklist cho input A ( da test bien 0 va FF chua )

      cp_A: coverpoint t.A{
        bins zeros = {0}; 
        bins max = {8'hff}; 
        bins other = default; // cac truong hop con lai 
      }

      //3. Checklist cho input B 
      cp_B:coverpoint t.B{
        bins zeros = {0}; 
        bins max = {8'hff}; 
        bins others = default; 
      }
      //4. Cross coverage 
      // da test phep nhan voi so 0 chua 
      cross_op_A_B: cross cp_op, cp_A, cp_B{
        // Phep nhan voi so 0 
        bins mul_zero = binsof(cp_op) intersect{MUL_OP} && (
                        binsof(cp_A.zeros) || binsof(cp_B.zeros)); 
        // Phep nhan voi so max (kiem tra tran so)
        bins mul_max = binsof(cp_op) intersect{MUL_OP} &&
                       (binsof(cp_A.max) || binsof(cp_B.max)); 
        // Bo qua cac truong hop khac (tat tinh nangtu sinh bin rac)
         option.cross_auto_bin_max = 0; 
      }
   endgroup 
   // constructor 
   function new(string name, uvm_component parent); 
      super.new(name,parent); 
      // Khoi tao covergroup 
      op_cov = new(); 
   endfunction 

   //ham write (tu dong goi khi monitor gui du lieu sang)

   function void write(command_transaction t ); 
   //1. Copy transaction nhan duoc vao bien cuc bo 
      this.t = t; 
      //2. Danh dau vao check list 
      op_cov.sample(); 
   endfunction 
   function void report_phase(uvm_phase phase);
      super.report_phase(phase);
      // In ra log với ID là "COV"
      `uvm_info("COV", $sformatf("--------------------------------------------------"), UVM_LOW)
      `uvm_info("COV", $sformatf("TONG DO BAO PHU (COVERAGE): %0.2f %%", op_cov.get_inst_coverage()), UVM_LOW)
      `uvm_info("COV", $sformatf("--------------------------------------------------"), UVM_LOW)
   endfunction
endclass:functional_coverage 

