#!/bin/bash 
cd scripts_exercise4
lmp -in in.obstacle > out.obstacle -log log.log
log2txt.py log.log data.txt     # col2 = temp, col3 = potential eng
plot.py output.png data.txt 1,2,Temp 1,3,PE 1,6,Press     # same plot with curve labels
open image.00000.jpg                # view initial snapshot
open image.25000.jpg                # view final snapshot
open movie.mpg     
