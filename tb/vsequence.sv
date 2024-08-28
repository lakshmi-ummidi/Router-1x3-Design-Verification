class vsequence extends uvm_sequence#(uvm_sequence_item);
	`uvm_object_utils(vsequence);
	small_packet s_pkt;
	medium_packet m_pkt;
	big_packet b_pkt;
	bit [1:0]addr;
	sequence1 s1;
	sequence2 s2;
	s_sequencer s_seqr[];
	d_sequencer d_seqr[];
	vsequencer vseqr;
	env_cfg cfg;
	function new(string name = "vsequence");
		super.new(name);
	endfunction : new
	task body();
		if(!uvm_config_db#(env_cfg)::get(null, get_full_name(), "cfg", cfg))
			`uvm_fatal("vsequence","getting failed")
		s_seqr = new[cfg.no_of_sagnt];
		d_seqr = new[cfg.no_of_dagnt];
		assert($cast(vseqr, m_sequencer))
		else 
			begin
				`uvm_error("vsequence","UVM casting failed")
			end
		foreach(s_seqr[i])
			s_seqr[i] = vseqr.s_seqr[i];
		foreach(d_seqr[i])
			d_seqr[i] = vseqr.d_seqr[i];
	endtask : body
endclass : vsequence	

class small_vseq extends vsequence;
	`uvm_object_utils(small_vseq)
	function new(string name="small_vseq");
		super.new(name);
	endfunction : new
	task body();
		super.body();
		s_pkt = small_packet::type_id::create("s_pkt");
		s1 = sequence1::type_id::create("s1");
		if(!uvm_config_db#(bit [1:0])::get(null,get_full_name(),"bit",addr))
			`uvm_fatal("small_vseq","getting is failed")
		fork
			begin
				for(int i = 0; i < cfg.no_of_sagnt; i++)
					s_pkt.start(s_seqr[i]);
			end
			begin
				if(addr == 2'b00)
					s1.start(d_seqr[0]);
				if(addr == 2'b01)
					s1.start(d_seqr[1]);
				if(addr == 2'b10)
					s1.start(d_seqr[2]);
			end
		join
	endtask : body
endclass : small_vseq

class medium_vseq extends vsequence;
	`uvm_object_utils(medium_vseq)
	function new(string name = "medium_vseq");
		super.new(name);
	endfunction : new
	task body();
		super.body();
		m_pkt = medium_packet::type_id::create("m_pkt");
		s1 = sequence1::type_id::create("s1");
		if(!uvm_config_db#(bit [1:0])::get(null,get_full_name(),"bit",addr))
			`uvm_fatal("medium_vseq","getting is failed")
		fork
			begin
				for(int i = 0; i < cfg.no_of_sagnt; i++)
					m_pkt.start(s_seqr[i]);
			end
			begin
				if(addr == 2'b00)
					s1.start(d_seqr[0]);
				if(addr == 2'b01)
					s1.start(d_seqr[1]);
				if(addr == 2'b10)
					s1.start(d_seqr[2]);
			end
		join
	endtask : body
endclass : medium_vseq

class big_vseq extends vsequence;
	`uvm_object_utils(big_vseq)
	function new(string name = "big_vseq");
		super.new(name);
	endfunction : new
	task body();
		super.body();
		b_pkt = big_packet::type_id::create("b_pkt");
		s1 = sequence1::type_id::create("s1");
		if(!uvm_config_db#(bit [1:0])::get(null,get_full_name(),"bit",addr))
			`uvm_fatal("big_vseq","getting is failed")
		fork
			begin
				for(int i = 0; i < cfg.no_of_sagnt; i++)
					b_pkt.start(s_seqr[i]);
			end
			begin
				if(addr == 2'b00)
					s1.start(d_seqr[0]);
				if(addr == 2'b01)
					s1.start(d_seqr[1]);
				if(addr == 2'b10)
					s1.start(d_seqr[2]);
			end
		join
	endtask : body
endclass : big_vseq