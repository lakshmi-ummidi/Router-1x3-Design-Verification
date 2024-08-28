class router_base_test extends uvm_test;
	`uvm_component_utils(router_base_test)
	env envh;
	source_cfg s_cfg[];
	dest_cfg d_cfg[];
	env_cfg cfg;
	int no_of_sagnt = 1;
	int no_of_dagnt = 3;
	bit [1:0] addr;
	function new(string name = "router_base_test", uvm_component parent);
		super.new(name, parent);
	endfunction : new
	function void build_phase(uvm_phase phase);
		s_cfg = new[no_of_sagnt];
		d_cfg = new[no_of_dagnt];
		foreach(s_cfg[i])
			begin
				s_cfg[i] = source_cfg::type_id::create($sformatf("s_cfg[%0d]", i));
				if(!uvm_config_db#(virtual source_if)::get(this, "", "s_vif", s_cfg[i].vif))
					`uvm_fatal("router_base_test", "getting is failed")
				s_cfg[i].is_active = UVM_ACTIVE;
			end
		foreach(d_cfg[i])
			begin
				d_cfg[i] = dest_cfg::type_id::create($sformatf("d_cfg[%0d]", i));
				if(!uvm_config_db#(virtual dest_if)::get(this, "", $sformatf("d_vif[%0d]", i), d_cfg[i].vif))
					`uvm_fatal("router_base_test", "getting is failed")
				d_cfg[i].is_active = UVM_ACTIVE;
			end
		cfg = env_cfg::type_id::create("cfg");
		cfg.s_cfg = s_cfg;
		cfg.d_cfg = d_cfg;
		cfg.no_of_dagnt = no_of_dagnt;
		cfg.no_of_sagnt = no_of_sagnt;
		uvm_config_db#(env_cfg)::set(this, "*", "cfg", cfg);
		super.build_phase(phase);
		envh = env::type_id::create("envh", this);
	endfunction : build_phase
endclass : router_base_test

class small_packet_test extends router_base_test;
	`uvm_component_utils(small_packet_test)
	small_packet seq;
	function new(string name = "small_packet_test", uvm_component parent);
		super.new(name, parent);
	endfunction : new
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction : build_phase
	task run_phase(uvm_phase phase);
		addr = $urandom%3;
		uvm_config_db#(bit [1:0])::set(this, "*", "bit", addr);
		seq = small_packet::type_id::create("seq");
		phase.raise_objection(this);
		for(int i = 0; i < no_of_sagnt; i++)
			begin
				seq.start(envh.sagnt.sagt[i].seqr);
			end
		phase.drop_objection(this);
	endtask : run_phase
endclass : small_packet_test

class small_packet_test1 extends small_packet_test;
	`uvm_component_utils(small_packet_test1)
	sequence1 seq1;
	function new(string name = "small_packet_test1", uvm_component parent);
		super.new(name, parent);
	endfunction : new
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction : build_phase
	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		seq1 = sequence1::type_id::create("seq1");
		phase.raise_objection(this);
		if(addr == 2'b00)
			seq1.start(envh.dagnt.dagt[0].d_seqr);
		if(addr == 2'b01)
			seq1.start(envh.dagnt.dagt[1].d_seqr);
		if(addr == 2'b10)
			seq1.start(envh.dagnt.dagt[2].d_seqr);
		//#100;
		phase.drop_objection(this);
	endtask : run_phase
endclass : small_packet_test1		
	
class small_packet_test2 extends small_packet_test;
	`uvm_component_utils(small_packet_test2)
	sequence2 seq2;
	function new(string name = "small_packet_test2", uvm_component parent);
		super.new(name, parent);
	endfunction : new
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction : build_phase
	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		seq2 = sequence2::type_id::create("seq2");
		phase.raise_objection(this);
		if(addr == 2'b00)
			seq2.start(envh.dagnt.dagt[0].d_seqr);
		if(addr == 2'b01)
			seq2.start(envh.dagnt.dagt[1].d_seqr);
		if(addr == 2'b10)
			seq2.start(envh.dagnt.dagt[2].d_seqr);
		//#100;
		phase.drop_objection(this);
	endtask : run_phase
endclass : small_packet_test2

class medium_packet_test extends router_base_test;
	`uvm_component_utils(medium_packet_test)
	medium_packet seq;
	function new(string name = "medium_packet_test", uvm_component parent);
		super.new(name, parent);
	endfunction : new
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction : build_phase
	task run_phase(uvm_phase phase);
		addr = $urandom%3;
		uvm_config_db#(bit [1:0])::set(this, "*", "bit", addr);
		phase.raise_objection(this);
		seq = medium_packet::type_id::create("seq");
		for(int i = 0; i < no_of_sagnt; i++)
			begin
				seq.start(envh.sagnt.sagt[i].seqr);
			end
		phase.drop_objection(this);
	endtask : run_phase
endclass : medium_packet_test

class medium_packet_test1 extends medium_packet_test;
	`uvm_component_utils(medium_packet_test1)
	sequence1 seq1;
	function new(string name = "medium_packet_test1", uvm_component parent);
		super.new(name, parent);
	endfunction : new
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction : build_phase
	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		seq1 = sequence1::type_id::create("seq1");
		phase.raise_objection(this);
		if(addr == 2'b00)
			seq1.start(envh.dagnt.dagt[0].d_seqr);
		if(addr == 2'b01)
			seq1.start(envh.dagnt.dagt[1].d_seqr);
		if(addr == 2'b10)
			seq1.start(envh.dagnt.dagt[2].d_seqr);
		//#100;
		phase.drop_objection(this);
	endtask : run_phase
endclass : medium_packet_test1

class big_packet_test extends router_base_test;
	`uvm_component_utils(big_packet_test)
	big_packet seq;
	function new(string name = "big_packet_test", uvm_component parent);
		super.new(name, parent);
	endfunction : new
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction : build_phase
	task run_phase(uvm_phase phase);
		addr = $urandom%3;
		uvm_config_db#(bit [1:0])::set(this, "*", "bit", addr);
		seq = big_packet::type_id::create("seq");
		phase.raise_objection(this);
		for(int i = 0; i < no_of_sagnt; i++)
			begin
				seq.start(envh.sagnt.sagt[i].seqr);
			end
		phase.drop_objection(this);
	endtask : run_phase
endclass : big_packet_test

class big_packet_test1 extends big_packet_test;
	`uvm_component_utils(big_packet_test1)
	sequence1 seq1;
	function new(string name = "big_packet_test1", uvm_component parent);
		super.new(name, parent);
	endfunction : new
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction : build_phase
	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		seq1 = sequence1::type_id::create("seq1");
		phase.raise_objection(this);
		if(addr == 2'b00)
			seq1.start(envh.dagnt.dagt[0].d_seqr);
		if(addr == 2'b01)
			seq1.start(envh.dagnt.dagt[1].d_seqr);
		if(addr == 2'b10)
			seq1.start(envh.dagnt.dagt[2].d_seqr);
		//#100;
		phase.drop_objection(this);
	endtask : run_phase
endclass : big_packet_test1