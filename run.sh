#!/bin/bash 
cd tooltest
lmp -in in.micelle > out.micelle -log log.log  # run a short LAMMPS simulation
log2txt.py log.lammps data.txt    # create data.txt with columns of numbers
plot.py output.png data.txt 1,2,Temp 1,4,Emol    # ditto with curve labels
xdg-open output.png
xdg-open image.00000.jpg               # view first and last snapshots of atoms
xdg-open image.50000.jpg
eog image.*                            # view all the snapshots (GNOME)
xdg-open movie.mpg                   # play a movie of the simulation
xdg-open plot.pdf                    # display a saved plot file