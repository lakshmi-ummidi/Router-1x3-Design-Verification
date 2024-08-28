class small_vtest extends router_base_test;
	`uvm_component_utils(small_vtest)
	small_vseq vseq;
	function new(string name = "small_vtest", uvm_component parent);
		super.new(name, parent);
	endfunction : new
	function void build_phase(uvm_phase phase);	
		super.build_phase(phase);
	endfunction : build_phase
	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
		repeat(10)
			begin
				addr = $urandom%3;
				uvm_config_db#(bit [1:0])::set(this,"*","bit",addr);
				vseq = small_vseq::type_id::create("vseq");
				vseq.start(envh.vseqr);
			end
		phase.drop_objection(this);
	endtask : run_phase
endclass : small_vtest

class medium_vtest extends router_base_test;
	`uvm_component_utils(medium_vtest)
	medium_vseq vseq;
	function new(string name = "medium_vtest", uvm_component parent);
		super.new(name, parent);
	endfunction : new
	function void build_phase(uvm_phase phase);	
		super.build_phase(phase);
	endfunction : build_phase
	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
		repeat(10)
			begin
				addr = $urandom%3;
				uvm_config_db#(bit [1:0])::set(this,"*","bit",addr);
				vseq = medium_vseq::type_id::create("vseq");
				vseq.start(envh.vseqr);
			end
		phase.drop_objection(this);
	endtask : run_phase
endclass : medium_vtest

class big_vtest extends router_base_test;
	`uvm_component_utils(big_vtest)
	big_vseq vseq;
	function new(string name = "big_vtest", uvm_component parent);
		super.new(name, parent);
	endfunction : new
	function void build_phase(uvm_phase phase);	
		super.build_phase(phase);
	endfunction : build_phase
	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
		repeat(10)
			begin
				addr = $urandom%3;
				uvm_config_db#(bit [1:0])::set(this, "*", "bit", addr);
				vseq = big_vseq::type_id::create("vseq");
				vseq.start(envh.vseqr);
			end
		phase.drop_objection(this);
	endtask : run_phase
endclass : big_vtest

class small_vtest_bad extends router_base_test;
	`uvm_component_utils(small_vtest_bad)
	small_vseq vseq;
	function new(string name = "small_vtest_bad", uvm_component parent);
		super.new(name, parent);
	endfunction : new
	function void build_phase(uvm_phase phase);	
		set_type_override_by_type(source_xtn::get_type(),bad_xtn::get_type());
		super.build_phase(phase);
	endfunction : build_phase
	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
		repeat(10)
			begin
				addr = $urandom%3;
				uvm_config_db#(bit [1:0])::set(this,"*","bit",addr);
				vseq = small_vseq::type_id::create("vseq");
				vseq.start(envh.vseqr);
			end
		phase.drop_objection(this);
	endtask : run_phase
endclass : small_vtest_bad

class medium_vtest_bad extends router_base_test;
	`uvm_component_utils(medium_vtest_bad)
	medium_vseq vseq;
	function new(string name = "medium_vtest_bad", uvm_component parent);
		super.new(name, parent);
	endfunction : new
	function void build_phase(uvm_phase phase);	
		set_type_override_by_type(source_xtn::get_type(), bad_xtn::get_type());
		super.build_phase(phase);
	endfunction : build_phase
	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
		repeat(10)
			begin
				addr = $urandom%3;
				uvm_config_db#(bit [1:0])::set(this,"*","bit",addr);
				vseq = medium_vseq::type_id::create("vseq");
				vseq.start(envh.vseqr);
			end
		phase.drop_objection(this);
	endtask : run_phase
endclass : medium_vtest_bad

class big_vtest_bad extends router_base_test;
	`uvm_component_utils(big_vtest_bad)
	big_vseq vseq;
	function new(string name = "big_vtest_bad", uvm_component parent);
		super.new(name, parent);
	endfunction : new
	function void build_phase(uvm_phase phase);	
		set_type_override_by_type(source_xtn::get_type(), bad_xtn::get_type());
		super.build_phase(phase);
	endfunction : build_phase
	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
		repeat(10)
			begin
				addr = $urandom%3;
				uvm_config_db#(bit [1:0])::set(this,"*","bit",addr);
				vseq = big_vseq::type_id::create("vseq");
				vseq.start(envh.vseqr);
			end
		phase.drop_objection(this);
	endtask : run_phase
endclass : big_vtest_bad