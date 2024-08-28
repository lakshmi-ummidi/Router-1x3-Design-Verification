class vsequencer extends uvm_sequencer;
	`uvm_component_utils(vsequencer)
	s_sequencer s_seqr[];
	d_sequencer d_seqr[];
	env_cfg cfg;
	function new(string name = "vsequencer", uvm_component parent);
		super.new(name,parent);
	endfunction: new
	function void build_phase(uvm_phase phase);
		if(!uvm_config_db#(env_cfg)::get(this, "", "cfg", cfg))
			`uvm_fatal("vsequencer","getting is failed")
		s_seqr = new[cfg.no_of_sagnt];
		d_seqr = new[cfg.no_of_dagnt];
		super.build_phase(phase);
	endfunction : build_phase
endclass : vsequencer