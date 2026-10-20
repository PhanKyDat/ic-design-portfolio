# cocotb setup
export COCOTB_REDUCED_LOG_FMT=1
export PYTHONPATH := ../02-rgb-mixer/test:$(PYTHONPATH)
export LIBPYTHON_LOC=$(shell cocotb-config --libpython)

test_wrapper:
	rm -rf sim_build/
	mkdir sim_build/
	iverilog -o sim_build/sim.vvp -DMPRJ_IO_PADS=38 -s wrapper -s dump -g2012 wrapper.v test/dump_wrapper.v ../02-rgb-mixer/src/*.v
	MODULE=test.test_wrapper vvp -M $$(cocotb-config --prefix)/cocotb/libs -m libcocotbvpi_icarus sim_build/sim.vvp

show_wrapper:
	gtkwave wrapper.vcd wrapper.gtkw

