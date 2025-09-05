@REM  Remove old output files

erase G1.bin G1.lis G1_log.txt

erase G3.bin G3.lis G3_log.txt

erase G4.bin G4.lis G4_log.txt

erase G5.bin G5.lis G5_log.txt



@REM  Run the G1 (control) simulation

century_47.exe -s G1 -n G1 > G1_log.txt

list100_47.exe G1 G1 outvars.txt



@REM  Run the G3 simulation

century_47.exe -s G3 -n G3 > G3_log.txt

list100_47.exe G3 G3 outvars.txt



@REM  Run the G4 simulation

century_47.exe -s G4 -n G4 > G4_log.txt

list100_47.exe G4 G4 outvars.txt



@REM  Run the G5 simulation

century_47.exe -s G5 -n G5 > G5_log.txt

list100_47.exe G5 G5 outvars.txt




pause