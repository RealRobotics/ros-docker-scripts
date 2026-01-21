# ros-docker-scripts

The repo houses scripts scripts to run Robot Operating system (ROS) dockers.

1. The `docker` scripts are intended for text only dockers suitable for building, running and testing code that does not need graphic tools.
2. The `nvidia_docker` scripts do the same as that `docker` scripts and also allow the use of graphical tools such as `RQt` and CUDA cores for simulation in `Gazebo`.

The scripts create a standard base container for a release of ROS.  The versions used on this branch are:

| Item | Version |
| --- | --- |
| Ubuntu | Noble Numbat |
| ROS | Kilted Kaiju |
| Docker | 29.1.5 |
| NVidia driver | 580 |
| CUDA | 13.0 |

If you want to use these scripts for your own project, just include this repo in your top level project repo, create your own branch and change as needed.

## Acknowledgments

© 2022,2025 University of Leeds.

The author, A. Blight, has asserted his moral rights.
