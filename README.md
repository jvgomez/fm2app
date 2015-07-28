FM2app 

V2.0: 01/10/2014
David Palomo's [B.Sc. Thesis](http://javiervgomez.com/pages/matlab-graphical-user-interface-to-fast-marching-square-algorithms.html)

V1.0: 22/10/2013
Javier V. Gómez
www.javiervgomez.com

Creative Commons 3.0 Attribution, Share-Alike
http://creativecommons.org/licenses/by-sa/3.0/


### DISCLAIMER:
The main purpose of this code is educational and focused on academic research. It is not optimized, its documentation can be poor and it is not bug-free at all. Because of this, it is given without any warranty.

If you find any bug or have any feature request, please let me know by contacting me (javvgomez _at_ gmail.com) or by any other method 
described in my website www.javiervgomez.com


### DEPENDENCIES:
This code requires the Gabriel Peyré's Fast Marching Toolbox to be installed and included in the Matlab path. Instructions about getting,
compiling and setting this toolbox can be found in:

http://javiervgomez.com/pages/fast-marching-toolbox-installation-tutorial.html


### INSTRUCTIONS:

To run this program you need matlab. Open the guide:

>> guide

and then open FM2app.fig file and press the play button (ctrl+T).


Data is structured as follows:
- Algorithms: Main FM2 algorithms, this is the most important part of the code. It is ready to be used out of the Matlab GUI.
- Examples: ready-to-run Matlab functions using the main algorithms in Algorithms/ to show their use without the GUI.
- Data: maps and useful data to test the algorithms.
- fm2tools: auxiliar functions of common use together with FM2 code.
- guitools: scripts which help to make clear the FM2app.m code.
- output: default folder when saving files.
- thridparty: Matlab scripts and toolboxes got from http://www.mathworks.com/matlabcentral/fileexchange. Note that these files have a different license: BSD license.

### WORKSPACE SAVED ELEMENTS
The workspace MAT file saved has the following variables:

- fm2F : MxN double variable representing the velocities map. It should be between 0 and 1.
- fm2T: MxN double variable representing the times-of-arrival map. It goes from 0 to 1.
- fm2map: MxN logical variable representing the binary occupancy grid map of the environment.
- fm2path: 2xP points representing the path from the start to the goal point.
- fm2sat: double scalar, saturation value used when computing fm2F.
- fm2times: double scalar, fm2times(1) is the time employed to compute fm2F,
			   fm2times(2) is the time employed to compute fm2T and path.

- fm2vels: 2x100 vector containing relative velocity for 100 waypoints of the original path and the index of the waypoint within the initial path.
- fm2start_point: 2x1 uint which contains the start point of the computed path in [X,Y] which corresponds to [COL, ROW]!!
- fm2goal_point: 2x1 uint which contains the goal point of the computed path in [X,Y] which corresponds to [COL, ROW]!!

###  KNOWN BUGS
- Figures saved do not look as they should (gray margins, not centered, etc).
