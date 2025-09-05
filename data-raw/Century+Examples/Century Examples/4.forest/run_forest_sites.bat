@REM  Remove old output files

erase harvard.bin harvard.lis harvard2.lis harvard_out_log.txt

erase duke.bin duke.lis duke2.lis duke_out_log.txt



@REM  Run the Harvard Forest simulation

century_47.exe -s harvard -n harvard > harvard_out_log.txt

list100_47.exe harvard harvard outvars.txt

list100_47.exe harvard harvard2 outvars2.txt



@REM  Run the Duke Forest simulation

century_47.exe -s duke -n duke > duke_out_log.txt

list100_47.exe duke duke outvars.txt

list100_47.exe duke duke2 outvars2.txt



pause