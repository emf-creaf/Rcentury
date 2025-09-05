@REM  Remove old output files

erase xili.bin xili.lis xili_log.txt

erase high_ppt.bin high_ppt.lis high_ppt_log.txt

erase low_ppt.bin low_ppt.lis low_ppt_log.txt

erase sandy.bin sandy.lis sandy_log.txt

erase clay.bin clay.lis clay_log.txt



@REM  Run the control simulation

century_47.exe -s xili -n xili > xili_log.txt

list100_47.exe xili xili outvars.txt



@REM  Run the high precipitation simulation

century_47.exe -s high_ppt -n high_ppt > high_ppt_log.txt

list100_47.exe high_ppt high_ppt outvars.txt



@REM  Run the low precipitation simulation

century_47.exe -s low_ppt -n low_ppt > low_ppt_log.txt

list100_47.exe low_ppt low_ppt outvars.txt



@REM  Run the sandy soil simulation

century_47.exe -s sandy -n sandy > sandy_log.txt

list100_47.exe sandy sandy outvars.txt



@REM  Run the clay soil simulation

century_47.exe -s clay -n clay > clay_log.txt

list100_47.exe clay clay outvars.txt


pause