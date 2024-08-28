class source_seq extends uvm_sequence#(source_xtn); 
	`uvm_object_utils(source_seq);
	bit [1:0]addr;
	function new(string name = "source_seq");
		super.new(name);
	endfunction : new
endclass : source_seq

class small_packet extends source_seq;
	`uvm_object_utils(small_packet)
	function new(string name = "small_packet");
		super.new(name);
	endfunction : new
	task body();
		if(!uvm_config_db#(bit [1:0])::get(null, get_full_name(), "bit", addr))
			`uvm_fatal("small_packet", "getting is failed")
		req = source_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {header[7:2] inside {[0:16]} && header[1:0] == addr;});
		`uvm_info("small_packet", $sformatf("printing from sequence \n %s", req.sprint()),UVM_HIGH)
		finish_item(req);
	endtask : body
endclass : small_packet

class medium_packet extends source_seq;
	`uvm_object_utils(medium_packet)
	function new(string name = "medium_packet");
		super.new(name);
	endfunction : new
	task body();
		if(!uvm_config_db#(bit [1:0])::get(null, get_full_name(), "bit", addr))
			`uvm_fatal("medium_packet", "getting is failed")
		req = source_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {header[7:2] inside {[17:40]} && header[1:0] == addr;});
		`uvm_info("medium_packet", $sformatf("printing from sequence \n %s", req.sprint()),UVM_HIGH)
		finish_item(req);
	endtask : body
endclass : medium_packet
	
class big_packet extends source_seq;
	`uvm_object_utils(big_packet)
	function new(string name = "big_packet");
		super.new(name);
	endfunction : new
	task body();
		if(!uvm_config_db#(bit [1:0])::get(null, get_full_name(), "bit", addr))
			`uvm_fatal("big_packet", "getting is failed")
		req = source_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {header[7:2] inside {[40:63]} && header[1:0] == addr;});
		`uvm_info("big_packet", $sformatf("printing from sequence \n %s", req.sprint()),UVM_HIGH)
		finish_item(req);
	endtask : body
endclass : big_packet