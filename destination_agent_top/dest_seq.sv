class dest_sequence extends uvm_sequence#(dest_xtn); 
	`uvm_object_utils(dest_sequence)
	function new(string name = "dest_sequence");
		super.new(name);
	endfunction : new
endclass : dest_sequence

class sequence1 extends dest_sequence;
	`uvm_object_utils(sequence1)	
	function new(string name = "sequence1");
		super.new(name);
	endfunction : new
	
	task body();
		req = dest_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {delay inside {[1:29]};})
		finish_item(req);
	endtask : body
endclass : sequence1	
	
class sequence2 extends dest_sequence;
	`uvm_object_utils(sequence2)
	function new(string name = "sequence2");
		super.new(name);
	endfunction : new
	
	task body();
		req = dest_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {delay > 29;})
		finish_item(req);
	endtask : body
endclass : sequence2