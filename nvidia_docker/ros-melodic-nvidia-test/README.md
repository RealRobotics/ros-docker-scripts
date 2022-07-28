# Running the ros_melodic_nvdia docker image

__NOTE: This is included to verify that your PC is setup correctly to use the NVidia GPU from a docker.__

This is a bare bones version of the info in section 1.3 here:
<http://wiki.ros.org/docker/Tutorials/Hardware%20Acceleration>

I have included it in this repo as a quick way to verify that you have
everything setup correctly on your PC to run the main docker image.

Run the following commands:

```bash
cd docker/ros-melodic-nvidia-test
./build.bash
./run.bash
```

In the new shell on the container, run the command:

```bash
roscore > /dev/null & rosrun rviz rviz
```

RViz should start up.
