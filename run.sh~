Here is the list of tools we will use during the LAMMPS tutorial:

text editors for input files:
  Linux: emacs, vi, vim
  Mac: textEdit, vim
  Windows: Notepad
  use whichever one is familiar to you

Image, movie, and PDF viewers:
  Linux: xdg-open [filename]
  Mac: open [filename]
  Windows: start [filename]

Mac and Linux use movie.mpg and Windows uses movie.avi
For Windows, you will need to comment out the Mac/Linux "dump movie" command in the LAMMPS inputs
And uncomment the Windows line for movie.avi

Python installation
Matplotlib or another plotting software (e.g. Microsoft Excel)

lmp = LAMMPS executable
log2txt.py = Python script to extract thermodynamic data from a LAMMPS logfile
plot.py = Python script to plot columns of logfile data

-----------

The tooltest dir has data files to let you try out all of these tools.
Please do this BEFORE the tutorial, so you are familiar with how to
use them.

This simulation is a simple 2d model of small polar molecules forming
micelles in background fluid.

Here are the commands to type for Mac OS, for Windows or Linux see above.

% cd tooltest

% lmp -in in.micelle                # run a short LAMMPS simulation
                                    # this produces all the other files
                                    # except plot.pdf
% log2txt.py log.lammps data.txt    # create data.txt with columns of numbers

MacOS
-----
% plot.py data.txt 1,2 1,4          # plot 2 columns from data.txt
% plot.py data.txt 1,2,Temp 1,4,Emol    # ditto with curve labels
% open image.00000.jpg               # view first and last snapshots of atoms
% open image.50000.jpg
% open image*                        # view all the snapshots
% open movie.mpg                     # play a movie of the simulation
% open plot.pdf                   # display a saved plot file

Windows
-------
WARNING: on Windows PowerShell requires you to quote arguments with commas (e.g. "1,4,Emol") 
% plot.py data.txt "1,2" "1,4"              # plot 2 columns from data.txt
% plot.py data.txt "1,2,Temp" "1,4,Emol"    # ditto with curve labels

% start image.00000.jpg               # view first and last snapshots of atoms
% start image.50000.jpg

% start .                           # view all the snapshots in folder, double-click first image in folder
                                    # to open Photos app in Folder mode
% start movie.avi                   # play a movie of the simulation
% start plot.pdf                    # display a saved plot file

Linux
-----
% plot.py output.png data.txt 1,2 1,4          # plot 2 columns from data.txt
% plot.py output.png data.txt 1,2,Temp 1,4,Emol    # ditto with curve labels
% xdg-open output.png

% xdg-open image.00000.jpg               # view first and last snapshots of atoms
% xdg-open image.50000.jpg

% xdg-open image.*                       # view all the snapshots
% eog image.*                            # view all the snapshots (GNOME)
                                    
% xdg-open movie.mpg                   # play a movie of the simulation
% xdg-open plot.pdf                    # display a saved plot file

Try out your text editor of choice:

% vi in.micelle                  # open LAMMPS input script in a text editor
% vim in.micelle

-----------

Here is more info on how to use the 2 Python script tools:

Syntax for log2txt.py tool (Mac/Windows/Linux):
  log2txt.py logfile datafile col1 col2 ...
  logfile = name of the LAMMPS log file
  datafile = name of text data file to produce
  col1, col2, ... = optional column names to extract
    see the line in the LAMMPS logfile that starts with "Step ..."
      to see the column names
    e.g. Step E_pair Press Volume
  if col* args are not used, all columns are extracted
  if 3 col args are used, the datafile will have 3 columns of numbers

Syntax for plot.py tool (Mac/Windows):
  plot.py datafile X1,Y1 X2,Y2,Name ...
  datafile = name of text file to plot data from
  X1,Y1 = 2 integers separated by a comma or
          2 integers and a string separated by commas
          repeated as many times as desired
    each set of comma-separated arguments is a curve to plot
    1,3 means x-axis is column 1, y-axis is column 3
    the optional Name string will appear in the plot legend
  add as many curves to the same plot as you wish
  the plot will have a legend labeled by Y1, Y2, etc or the Names
  when the plot displays, you can click the disc icon at the bottom,
    to save the plot as a PNG or PDF file and give it a name,
    which can later be viewed with the image or PDF viewer

Syntax for plot.py tool (Linux package only):
  plot.py outputfile datafile X1,Y1 X2,Y2,Name ...
  outputfile = name of the image file
  datafile = name of text file to plot data from
  X1,Y1 = 2 integers separated by a comma or
          2 integers and a string separated by commas
          repeated as many times as desired
    each set of comma-separated arguments is a curve to plot
    1,3 means x-axis is column 1, y-axis is column 3
    the optional Name string will appear in the plot legend
  add as many curves to the same plot as you wish
  the plot will have a legend labeled by Y1, Y2, etc or the Names
  writes an image file which can then be viewed via xdg-open
