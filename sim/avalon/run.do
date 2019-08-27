if [file exists "work"] {vdel -all}
vlib work
vlog -f compile_sv.f 
vsim -L altera_mf_ver -L lpm_ver avalon_example_peripheral_tb -novopt -assertdebug
onbreak {resume}
log -r /*
do wave.do
run -all

