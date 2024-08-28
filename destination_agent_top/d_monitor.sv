class d_monitor extends uvm_monitor;
	`uvm_component_utils(d_monitor)
	
	dest_cfg d_cfg;
	virtual dest_if.MON vif;
	uvm_analysis_port#(dest_xtn)ap;
	dest_xtn xtn;
	
	function new(string name = "d_monitor", uvm_component parent);
		super.new(name, parent);
		ap = new("ap", this);
	endfunction : new
	
	function void build_phase(uvm_phase phase);
		if(!uvm_config_db#(dest_cfg)::get(this, "", "d_cfg", d_cfg))
			`uvm_fatal("d_monitor", "getting is failed")
		super.build_phase(phase);
	endfunction : build_phase
	
	function void connect_phase(uvm_phase phase);
		vif = d_cfg.vif;
	endfunction : connect_phase
	
	task run_phase(uvm_phase phase);
		forever 
			collect_data();
	endtask : run_phase
	
	task collect_data();
		xtn = dest_xtn::type_id::create("xtn");
		@(vif.mon_cb);
		wait(vif.mon_cb.read_en == 1)
		@(vif.mon_cb);
		xtn.header = vif.mon_cb.data_out;
		xtn.payload = new[xtn.header[7:2]];
		@(vif.mon_cb);
		foreach(xtn.payload[i])
			begin 
				xtn.payload[i] = vif.mon_cb.data_out;
				@(vif.mon_cb);
			end
		xtn.parity = vif.mon_cb.data_out;
		@(vif.mon_cb);
		`uvm_info("d_monitor", $sformatf("printing from monitor \n %s", xtn.sprint()), UVM_LOW)
		ap.write(xtn);
	endtask : collect_data
endclass : d_monitor