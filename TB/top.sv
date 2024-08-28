module top;
	`include "uvm_macros.svh"
	import uvm_pkg::*;
	import router_pkg::*;
	bit clock = 1;
	always #5 clock = ~clock;
	
	source_if s_vif(clock);
	dest_if d_vif0(clock);
	dest_if d_vif1(clock);
	dest_if d_vif2(clock);
	
	router_top DUT(.clock(clock),
				   .resetn(s_vif.resetn),
		           .pkt_valid(s_vif.pkt_valid),
				   .data_in(s_vif.data_in),
				   .read_enb_0(d_vif0.read_en),
				   .read_enb_1(d_vif1.read_en),
				   .read_enb_2(d_vif2.read_en),
				   .data_out_0(d_vif0.data_out),
				   .data_out_1(d_vif1.data_out),
				   .data_out_2(d_vif2.data_out),
				   .vld_out_0(d_vif0.valid_out),
				   .vld_out_1(d_vif1.valid_out),
				   .vld_out_2(d_vif2.valid_out),
				   .busy(s_vif.busy),
				   .error(s_vif.error)
				   );
	
	initial 
	begin
		uvm_config_db#(virtual source_if)::set(null, "*", "s_vif", s_vif);
		uvm_config_db#(virtual dest_if)::set(null, "*", "d_vif[0]", d_vif0);
		uvm_config_db#(virtual dest_if)::set(null, "*", "d_vif[1]", d_vif1);
		uvm_config_db#(virtual dest_if)::set(null, "*", "d_vif[2]", d_vif2);
		run_test();
	end
	property busy_check;
		@(posedge clock) 
		$rose(s_vif.pkt_valid) |=> s_vif.busy;
	endproperty
	A1: assert property (busy_check);
	
	property stable_data;
		@(posedge clock) 
		s_vif.busy |=> $stable(s_vif.data_in);
	endproperty
	A2: assert property (stable_data);

	property valid_signal;
		@(posedge clock) 
		$rose(s_vif.pkt_valid) |-> ##3 d_vif0.valid_out | d_vif1.valid_out | d_vif2.valid_out;
	endproperty
	V: assert property(valid_signal);
	
	property read_enb1;
		@(posedge clock) 
		$rose(d_vif0.valid_out) |=> ##[0:29] d_vif0.read_en;
	endproperty
	R1:assert property(read_enb1);
	
	property read_enb2;
		@(posedge clock) 
		$rose(d_vif1.valid_out) |=> ##[0:29] d_vif1.read_en;
	endproperty
	R2:assert property(read_enb2);
	
	property read_enb3;
		@(posedge clock) 
		$rose(d_vif2.valid_out) |=> ##[0:29] d_vif2.read_en;
	endproperty
	R3:assert property(read_enb3);

	property read_enb1_low;
		@(posedge clock) 
		d_vif0.valid_out ##1 !d_vif0.valid_out |=> ##[0:29] $fell(d_vif0.read_en);
	endproperty
	V1: assert property(read_enb1_low);
	
	property read_enb2_low;
		@(posedge clock) 
		d_vif1.valid_out ##1 !d_vif1.valid_out |=> ##[0:29] $fell(d_vif1.read_en);
	endproperty
	V2: assert property(read_enb2_low);
	
	property read_enb3_low;
		@(posedge clock) 
		d_vif2.valid_out ##1 !d_vif2.valid_out |=> ##[0:29] $fell(d_vif2.read_en);
	endproperty
	V3: assert property(read_enb3_low);
endmodule