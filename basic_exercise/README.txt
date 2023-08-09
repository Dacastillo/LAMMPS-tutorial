Tasks for Exercise basic

Goals: Run LAMMPS, plot its thermodynammic output, create on-the-fly
images and a movie.  Also make simple edits to an input script to
induce different behaviors.

The in.friction script is a 2d model of frictional effects when two
bumpy surfaces are dragged across each other.  In tribology (science
of friction), such bumps are called asperities.

This exercise is adapted from the examples/friction/in.friction input
script

The file in.friction.original is a copy of in.friction.  After you
edit in.friction, you can restore it using the copy if needed.

The file movie.original.mpg is a copy of the movie.mpg file created by
running the original input script.

-------------------
-------------------

(1) Perform a run, plot thermo output, visualize the simulation

% cd tutorial/exercise_basic

% lmp -in in.friction
% log2txt.py log.lammps data.txt     # col2 = temp, col6 = pressure

% plot.py data.txt 1,2 1,6           # plot temp and pressure on same plot
% plot.py data.txt 1,2,Temp 1,6,Press     # same plot with curve labels
% open image.00000.jpg                # view initial snapshot
% open image.20000.jpg                # view final snapshot
% open movie.mpg                      # play movie

NOTE: The temperature is for the y-dimension motion only.  So that
the large x-velocity does not affect it.

-------------------

(2) Change size of the asperities

Edit the in.friction file at location flagged "TASK 2".
Change the radii of the two asperities.
The two asperities do not need to be the same size.
Rerun and visualize the simulation.

-------------------

(3) Run for two cycles instead of one

Edit the in.friction file at location flagged "TASK 3".
Change the run to be twice as many timesteps.
Note that Nsteps * timestep-size = x box length = 50.
Rerun and visualize the simulation.

-------------------

(4) Change the shape of the asperities

Edit the in.friction file at location flagged "TASK 4".
This will create two block-shaped asperities instead of half-sphere shaped.
Note that you MUST comment out the creation of the half-sphere bumps.
Rerun and visualize the simulation.

EXTRA: You can leave all 4 asperities un-commented, if you change the
position of the second pair so that none of the asperities initially
overlap with each other.  The arguments to the region commands set the
position and size of each asperity.  You will need to look at the
region command doc page to figure this out.

EXTRA: You could use the region cone command (in a 2d simulation) to
create triangle-shaped asperities.  Again, you will need to use the
region commmand doc page to figure this out.

