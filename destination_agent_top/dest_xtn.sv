class dest_xtn extends uvm_sequence_item;
	`uvm_object_utils(dest_xtn)
	bit [7:0]header;
	bit [7:0]payload[];
	bit [7:0]parity;
	rand bit [5:0]delay;
	
	function new(string name = "dest_xtn");
		super.new(name);
	endfunction : new
	
	function void do_print(uvm_printer printer);
		super.do_print(printer); 
		printer.print_field("header", header, 8, UVM_HEX);
		foreach(payload[i])
			printer.print_field($sformatf(" payload_data[%0d]", i), payload[i], 8, UVM_HEX);
		printer.print_field("parity", parity, 8, UVM_HEX);
		printer.print_field("no_of_cycles", delay, 6, UVM_DEC);
	endfunction : do_print
endclass : dest_xtn 