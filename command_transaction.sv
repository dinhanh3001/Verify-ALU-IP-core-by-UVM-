class command_transaction extends uvm_sequence_item; 
   // UVM factory (dung cac tinh nang tu dong sau nay)
   //1. Khai bao cac truong du lieu 
   // dung rand de sau nay co the random du lieu 
   `uvm_object_utils(command_transaction)
   rand byte        A; 
   rand byte        B; 
   rand operation_t op; 
   // bien luu ket qua 
   shortint  result; 
   //2. Constructor 
   function new(string name = "command_transaction"); 
      super.new(name); 
   endfunction : new 
   //3. Ham convert2string (de in ra log cho dep) 
   // chuan cong nghiep: Khong dung display trong class, ma tao chuoi uvm de in 
   virtual function string convert2string(); 
      string s ; 
      s = $sformatf("A: %02h OP: %s B: %2h  result: %4h", A, op.name(), B,result); 
      return s; 
   endfunction : convert2string 
   //4. Constraint ( rang buoc randome)

   constraint valid_op_c {
    op inside {ADD_OP, AND_OP, XOR_OP, MUL_OP}; 
   }
endclass: command_transaction

