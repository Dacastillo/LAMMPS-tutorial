Tasks for Exercise properties

Goals: Learn how to compute various material properties in a LAMMPS
input script.  This will require reading the LAMMPS Manual doc pages
for the relevant commands to figure out the correct syntax.

The in.lj script is a 2d model of simple Lennard-Jones system.
Depending on the choice of density and pressure, it is a liquid or
solid.  The following properties can be easily measured:

(a) radial distribution function
(b) diffusion coefficient
(c) per-atom coordination numbers which indicate defects in a solid
(d) shear viscosity for a liquid

The file in.lj.original is a copy of in.lj.  After you edit
in.lj, you can restore it using the copy if needed.

The file movie.original.mpg is a copy of the movie.mpg file created by
running the original input script.

For more info on calculating diffusion coefficients, see Section 8.3.8
(Howto diffusion) of the LAMMPS manual and the examples/DIFFUSE dir.

For more info on calculating liquid viscosiy, see Section 8.3.7 (Howto
viscosity) of the LAMMPS manual and the examples/VISCOSITY dir.

For 3d systems, many compute */atom commands in LAMMPS can compute
per-atom defect properties based on the neighborhood of atoms around
each atom.  Examples are compute coord/atom, cna/atom, centro/atom,
ptm/atom.

-------------------
-------------------

(1) Perform a run, plot thermo output, visualize the simulation

% cd tutorial/exercise_properties

% lmp -in in.lj
% log2txt.py log.lammps data.txt     # col2 = temp, col3 = potential eng
                                     # col6 = pressure

% plot.py data.txt 1,2 1,3 1,6       # plot 3 values on same plot
% plot.py data.txt 1,2,Temp 1,3,PE 1,6,Press     # same plot with curve labels
% open image.00000.jpg                # view initial snapshot
% open image.25000.jpg                # view final snapshot
% open movie.mpg                      # play movie

This movie is fairly uninteresting.  It just shows a fluid where
individual particles are slowly diffusing.  But it can tell you
whether the system is a liquid vs solid.

-------------------

(2) Compute the radial distribution function (RDF)

The script defines 3 variables, all in reduced Lennard-Jones units:

rho = density
temp = temperature
cutoff = distance cutoff for LJ potential

They can be changed directly at the top of the script
or from the command-line:

% lmp -v rho 0.5 -in in.lj

For this task, experiement with changing rho.  Rho values from roughly
0.1 to ~0.9 are a liquid at the default temperature of 1.0.  Rho
values of 1.0 or higher are a solid.

Check the differences in visual structure by playing the movies for
simulations of a few rho values.

A more quantitative measure of liquid vs solid is to examine the RDF.

Add compute rdf and fix ave/time commands to the "material properties"
section of the input script.  Look at the command doc pages for the
correct syntax.  The fix ave/time command can output its tabulated
alues to a file you specify.  To get a smooth RDF curve, you should
average over RDF calculations on 1000s of timesteps.  You can then
"cut" the columnar table from the file and "paste" it into a new data
file, then plot the RDF value versus distance via plot.py.  

Type this:

open rdf.original.png

to see a plot of the RDF versus distance for the original in.lj script
with the commands from Answers.txt added.

Your task is to produce plots like rdf.png for various rho values.
You should see a clear difference in the RDF for liquids vs solids.

-------------------

(2) Compute the mean-squared displacement (MSD) and diffusion
coefficient

The compute msd command computes 4 values, the xyz components of MSD,
and the total MSD.  This is relative to the time=0 coordinates of the
particles when the compute is defined in the input script.  The
diffusion coefficient D is the slope of the MSD curve versus time (in
LJ tau units) divided by 4 for a 2d system.  Note that the timstep in
in.lj is 0.005, meaning tau = 200 timesteps.

Add a compute msd and variable command to the "material properties"
section of the input script.  The variable should compute D using the
current MSD value to approximate a straight line from time=0 with
MSD=0 to the current time.

Also output MSD and D as part of thermodynamic output.  D will change
as the system equilibrates.  The final value at the end of the run is
the "most accurate" D value, using MSD data from the entire run.

Type this:

open msd.original.png

to see a plot of the MSD versus timestep for the original in.lj script
with the commands from Answers.txt added.

Your task is to produce plots like this from the MSD column of data in
the thermodyanmic output.  And to compute a D value from the MSD data.

Does D change as you expect as you vary the density rho and/or
temperature temp of the system?  What happens to the MSD curve and to
D once rho is high enough for the system to be a solid?

EXTRA: By using the fix vector command you can produce a vector
internal to LAMMPS that contains MSD values at different time.  The
slope() function of the variable command can fit a line to this
vector.  This is a more accurate measure of D than the simple 2-point
line.  If you output the new variable value with thermodynamic output
it should be close to the 2-point values, since the MSD data is nearly
a straight line.

-------------------

(4) Compute and colorize defects for a solid state system

The compute coord/atom command can compute a coordination number for
each particle (# of near neighbors).  This value can be used to color
each atom so that an image of the system shows defects.

In the "material properties" section of the input script, add a
compute coord/atom command (with an appropriate cutoff to capture
only nearest neighbors) and 2 dump commands, one for images and one for a
movie. Use the output of compute coord/atom to color the atoms.

IMPORTANT: Run a simulation for a solid with the density (rho)
variable set to 1.0.

If you play the movie you should see the defect structure move and
change.  If you examine individual images you can see the individual
defects clearly.

You can experiement with the density and temperature to create
different numbers and kinds of defects.

Type this:

open cnum.original.mpg

to play a movie of the defect structure for the original in.lj script
with the commands from Answers.txt added.

-------------------

(5) Compute the viscosity (eta) for a liquid system

In this task we will use a non-equilibrium MD (NEMD) method to measure
shear viscosity, where the system is sheared in the x-direction
continuously.  The off-diagonal xy pressure tensor component Pxy is
the momentum flux in the y-direction due to the shear.  The ratio Pxy
/ shear-rate is the viscosity.

NOTE: The changes to in.lj needed to perform an NEMD simulation and
compute viscosity are more complicated than any others in the Tutorial
exercises.  Thus the code changes are explained in full here.  You can
study the doc pages for the various commands to figure out what they
are doing.

(a) Edit these 2 lines in in.lj, so that the first is commented out,
the second is un-commented:

region		box block 0 20 0 20 -0.25 0.25
#region		box prism 0 20 0 20 -0.25 0.25 0 0 0

This will allow the box to be deformed via the fix deform command.

(b) Add all these lines to the "material properties" section of the
input script:

# add ramp to particle velocities to match box deformation

velocity        all ramp vx 0 ${srate} y 0 20 sum yes

# turn off NVE time integration and Langevin thermostatting
# fixes for time integration with a SLLOD thermostat, and box deformation

unfix           1
unfix           2
fix		1 all nvt/sllod temp ${temp} ${temp} 0.1
variable	xyrate equal ${srate}/ly 
fix		2 all deform 1 xy erate ${xyrate} remap v

# instantaneous eta and time-averaged eta

variable	eta equal -pxy/v_xyrate      
fix		etaave all ave/time 10 100 1000 v_eta ave running

# profile.nemd = y-dim velocity profile of shearing fluid

compute         layers all chunk/atom bin/1d y center 0.05 units reduced
fix		4 all ave/chunk 20 250 5000 layers vx file profile.nemd

# output temperature of sheared fluid, instant and time-ave eta

compute		tdeform all temp/deform
thermo_style	custom step temp c_tdeform epair press pxy v_eta f_etaave

(c) Run the altered input script and play the resulting movie

You should see the simulation box shear left-to-right and flip back to
the left multiple times.  If you look closely, the fluid should be
flowing consistent with the box deformation.  Particles at the bottom
are barely moving.  Particles at the top should move at the speed of
the upper edge of the box.

The last 2 columns of the thermodynamic output are the instantaneous
and time-averaged viscosity (eta).  The latter converges reasonably
well in 25000 steps.

The last average-time table in the profile.nemd box can be "cut" and
"pasted" into a new data file.  Use the plot.py tool to plot the
velocity profile (col 3) versus the y coordinate (col 2).  When fully
equilibrated, the profile should be linear and range from 0.0 for y =
0.0 to srate (2.5) at y = 20 (upper box edge).  This 25000-step run is
too short for full equilibration to occur.

(d) You can now experiment with changing the density (rho),
temperature (temp), and shear-rate (srate) variables to see how they
affect the viscosity.

Type this:

open eta.original.mpg

to play a movie of the shearing simulation for the original in.lj
script with the changes described above.

Type this:

open vx.original.png

to see a plot of the Vx velocity profile in the y-dimension for the
the original in.lj script with the changes described above.

