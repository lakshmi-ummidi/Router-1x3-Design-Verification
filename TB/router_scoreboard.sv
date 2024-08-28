class router_scoreboard extends uvm_scoreboard;
	`uvm_component_utils(router_scoreboard)
	uvm_tlm_analysis_fifo#(source_xtn) fifo1;
	uvm_tlm_analysis_fifo#(dest_xtn) fifo2[];
	
	int data_verified_count;
	source_xtn xtn1;
	dest_xtn xtn2;
	env_cfg cfg;
	
	source_xtn scov_data;
	dest_xtn dcov_data;
	
	covergroup router_fcov1;
		option.per_instance = 1;
		
		CHANNEL: coverpoint scov_data.header[1:0]{bins low = {2'b00};
												  bins mid1 = {2'b01};
												  bins mid2 = {2'b10};
												  }
		PAYLOAD_SIZE: coverpoint scov_data.header[7:2]{bins small1 = {[1:15]};
													   bins medium1 = {[16:30]};
													   bins large1 = {[31:63]};
													   }
		BAD_PKT: coverpoint scov_data.error{bins bad_pkt = {1};}
		
		cross1: cross CHANNEL, PAYLOAD_SIZE;
		
		cross2: cross CHANNEL, PAYLOAD_SIZE, BAD_PKT;
	endgroup : router_fcov1
	
	covergroup router_fcov2;
		option.per_instance = 1;
		
		CHANNEL: coverpoint dcov_data.header[1:0]{bins low = {2'b00};
												  bins mid1 = {2'b01};
												  bins mid2 = {2'b10};
												  }
		PAYLOAD_SIZE: coverpoint dcov_data.header[7:2]{bins small1 = {[1:15]};
													   bins medium1 = {[16:30]};
													   bins large1 = {[31:63]};
													   }
		
		cross1: cross CHANNEL, PAYLOAD_SIZE;
	endgroup : router_fcov2
	
	function new(string name = "router_scoreboard", uvm_component parent);
		super.new(name, parent);
		router_fcov1 = new();
		router_fcov2 = new();
	endfunction : new
	
	function void build_phase(uvm_phase phase);
		if(!uvm_config_db#(env_cfg)::get(this, "", "cfg", cfg))
			`uvm_fatal("router_scoreboard", "getting is failed")
		fifo1 = new("fifo1", this);
		fifo2 = new[cfg.no_of_dagnt];
		foreach(fifo2[i])
			fifo2[i] = new($sformatf("fifo2[%0d]", i), this);
		super.build_phase(phase);
	endfunction : build_phase
	
	task run_phase(uvm_phase phase);
		fork 
			begin
				forever
					begin
						fifo1.get(xtn1);
						`uvm_info("SB","Write_data",UVM_LOW)
						xtn1.print;
						scov_data = xtn1;
						router_fcov1.sample();
					end
			end
			begin
				forever
					begin
						fork 
							begin
								fifo2[0].get(xtn2);
								`uvm_info("SB","Read[0]_Data",UVM_LOW)
								xtn2.print;
								check_data(xtn2);
								dcov_data = xtn2;
								router_fcov2.sample();
							end
							begin
								fifo2[1].get(xtn2);
								`uvm_info("SB","Read[1]_Data",UVM_LOW)
								xtn2.print;
								check_data(xtn2);
								dcov_data = xtn2;
								router_fcov2.sample();
							end
							begin
								fifo2[2].get(xtn2);
								`uvm_info("SB","Read[2]_Data",UVM_LOW)
								xtn2.print;
								check_data(xtn2);
								dcov_data = xtn2;
								router_fcov2.sample();
							end
						join_any
						disable fork;
					end
			end
		join
	endtask : run_phase
	
	task check_data(dest_xtn xtn);
		if(xtn1.header == xtn.header)
			`uvm_info("SB","Read Header data matched Successfully",UVM_MEDIUM)
		else
			`uvm_error("SB","Failed header Reading")
			
		if(xtn1.payload == xtn.payload)
			`uvm_info("SB","Read payload data matched Successfully",UVM_MEDIUM)
		else
			`uvm_error("SB","Failed payload data Reading")
		if(xtn1.parity == xtn.parity)
			`uvm_info("SB","Read parity data matched Successfully",UVM_MEDIUM)
		else
			`uvm_error("SB","Failed  parity Reading")
		data_verified_count++;
	endtask: check_data
	function void report_phase(uvm_phase phase);
		`uvm_info("SB",$sformatf("No. of transactions verified %0d", data_verified_count),UVM_MEDIUM)
	endfunction : report_phase
endclass : router_scoreboard