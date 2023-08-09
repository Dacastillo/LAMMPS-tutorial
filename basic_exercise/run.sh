#!/bin/bash 
cd exercise_basic4
lmp -in in.friction > out.friction -log log.log  # run a short LAMMPS simulation
log2txt.py log.log data.txt    # create data.txt with columns of numbers
plot.py output.png data.txt 1,2,Temp 1,6,Press    # ditto with curve labels
xdg-open image.00000.jpg               # view first and last snapshots of atoms
xdg-open image.20000.jpg
xdg-open movie.mpg                   # play a movie of the simulation
