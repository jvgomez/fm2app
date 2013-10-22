The workspace MAT file saved has the following variables:

- fm2F : MxN double variable representing the velocities map. It should be between 0 and 1.

- fm2T: MxN double variable representing the times-of-arrival map. It goes from 0 to 1.

- fm2map: MxN logical variable representing the binary occupancy grid map of the environment.

- fm2path: 2xP points representing the path from the start to the goal point.

- fm2sat: double scalar, saturation value used when computing fm2F.

- fm2times: double scalar, fm2times(1) is the time employed to compute fm2F,
			   fm2times(2) is the time employed to compute fm2T and path.

- fm2vels: 2x100 vector containing relative velocity for 100 waypoints of the original path and the index of the waypoint within the initial path.
