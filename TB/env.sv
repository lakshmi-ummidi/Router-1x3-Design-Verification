class env extends uvm_env;
	`uvm_component_utils(env)
	source_agt_top sagnt;
	dest_agt_top dagnt;
	vsequencer vseqr;
	env_cfg cfg;
	router_scoreboard sb;
	function new(string name = "env", uvm_component parent);
		super.new(name, parent);
	endfunction : new
	function void build_phase(uvm_phase phase);
		if(!uvm_config_db#(env_cfg)::get(this, "", "cfg", cfg))
			`uvm_fatal("env_cfg","getting is failed")
		super.build_phase(phase);
		sagnt = source_agt_top::type_id::create("sagnt", this);
		dagnt = dest_agt_top::type_id::create("dagnt", this);
		vseqr = vsequencer::type_id::create("vseqr",this);
		sb = router_scoreboard::type_id::create("sb", this);
	endfunction : build_phase
	function void connect_phase(uvm_phase phase);
		for(int i = 0;i < cfg.no_of_sagnt; i++)
			vseqr.s_seqr[i] = sagnt.sagt[i].seqr;
		for(int i=0; i < cfg.no_of_dagnt; i++)
			vseqr.d_seqr[i] = dagnt.dagt[i].d_seqr;
		for(int i = 0;i < cfg.no_of_sagnt; i++)
			sagnt.sagt[i].mon.ap.connect(sb.fifo1.analysis_export);
		for(int i = 0;i < cfg.no_of_dagnt; i++)
			dagnt.dagt[i].d_mon.ap.connect(sb.fifo2[i].analysis_export);
	endfunction : connect_phase
endclass : env