Tasks for Exercise scripts

Goals: Learn how to alter an input script and add new commands.  This
will require reading the LAMMPS Manual doc pages for the relevant
commands to figure out the correct syntax.

The in.obstacle script is a 2d model of Poiseuille flow of a fluid in
a micro-channel around an obstacle.  A constant load is applied to the
upper wall so that it adapts to the pressure created by the flowing
fluid.

This exercise is adapted from the examples/obstacle/in.obstacle input
script

The file in.obstacle.original is a copy of in.obstacle.  After you
edit in.obstacle, you can restore it using the copy if needed.

The file movie.original.mpg is a copy of the movie.mpg file created by
running the original input script.

-------------------
-------------------

(1) Perform a run, plot thermo output, visualize the simulation

% cd tutorial/exercise_scripts

% lmp -in in.obstacle
% log2txt.py log.lammps data.txt     # col2 = temp, col3 = potential eng
                                     # col6 = pressure

% plot.py data.txt 1,2 1,3 1,6       # plot 3 values on same plot
% plot.py data.txt 1,2,Temp 1,3,PE 1,6,Press     # same plot with curve labels
% open image.00000.jpg                # view initial snapshot
% open image.25000.jpg                # view final snapshot
% open movie.mpg                      # play movie

-------------------

(2) Add 3 variable commands to simplify setting key flow parameters

These are the 3 parameters:

(a) The fix addforce command adds a force which pushes the fluid
particles to the right.  This will become a "push" variable.

(b) The fix viscous command adds a damping force which makes the fluid
more viscous.  pushes the fluid to the right.  This will become a
"damp" variable.

(c) The fix aveforce command pushes downward in the upper channel wall to
compress the fluid.  This will become a "compress" variable.

Steps:

(2a) Add the 3 variables at the top of the script in the "flow
variables" section.  Make them index-style variables, so they can also
be set from the command line.  Look at the variable command doc page
for the correct syntax.

(2b) Look at the doc pages for the fix addforce, viscous, and aveforce
commands to learn their syntax.  Find the 3 commands in the input
script.  Use the current value of the 3 params as the value to set in
the new variable commands.

(2c) Edit the 3 fix commands so they use the new variables.  E.g. the
fix addforce command should use ${push}.

(2d) Rerun the new script to insure it works the same as before.

(2e) Now you can alter the variable settings to change the properties
of the channel flow.  You can edit the values at the top of input
script, or do it from the command line, like this:

% lmp -v push 0.3 -v compress -1.0 -in in.obstacle

Experiment with running simulations with different flow parameter.

QUESTION: Do the new movies have flows which match your intuition as
to how you changed the flow parameters?

EXTRA: You can replot the thermo data to see if those values change as
well with the flow properties.

-------------------

(3) Change the size of the obstacle in the flow

The spherical obstacle size appears in 2 region sphere commands with
region IDs void and voidout.  These regions are used in the following
2 commands to delete atoms inside the region and then use the region
surface as a outward-facing "wall" to repel flow atoms.

Look at the doc page for the region command.  Edit the 2 region
commands to make the obstacle smaller or larger.  

NOTE: The size in the first command needs to be slightly larger than
in the second.  This is to insure no particle is exactly on the region
surface.

NOTE: You should not alter the size or position of the obstacle so
that it overlaps the boundaries of the channel.

Rerun the simulation and visualize it.

-------------------

(4) Add a second obstacle to the flow

The 4 commands that define the obstacle are region sphere (twice),
delete_atoms, and fix wall/region.  Look at their doc pages to learn
their syntax.

Copy the 4 commands to make a new obstacle.  Each command will need to
be edited to create different IDs for the regions and fix, and also
change the position of the 2nd obstacle.

Rerun the simulation and visualize it.

QUESTION: What happens if the 2 obstacles overlap?

EXTRA: You could add a 3rd or 4th obstacle in the same manner.

-------------------

(5) Change the obstacle to have a different shape

The two region commmands (IDs = void and voidout) determine the shape
of the region.  Use the region doc page to alter the shape to be a
block or prism.  Or a cone, which in 2d will be a triangle.

NOTE: As with the spherical region, the first region command needs to
create a slightly larger region in all directions.  If you don't do
this, you may get an ERROR when the simulation runs about a particle
being outside the surface of the region, which in this case means
inside the obstacle.

Rerun the simulation and visualize it.
