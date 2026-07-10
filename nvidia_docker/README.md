# Docker

The files in this directory provides the user with a method to quickly build and test the simulation code in a docker container that also support hardware acceleration for NVidia GPUs.  Scripts are provided to create the docker image and to start, stop and attach to the docker container.

__IMPORTANT NOTE: Running this docker requires an NVidia graphics card with 4GB RAM or more.__

## Getting started

The docker image is setup for NVidia only and uses the `nvidia-docker2` software.

### Install and test the NVidia docker toolkit

On your PC, install the NVidia container toolkit using the script:

```text
./nvidia_docker/install_nvidia_container_toolkit.bash
```

If all goes well, you should see something like this:

```text
Thu Jul 28 08:11:03 2022
+-----------------------------------------------------------------------------+
| NVIDIA-SMI 515.48.07    Driver Version: 515.48.07    CUDA Version: 11.7     |
|-------------------------------+----------------------+----------------------+
| GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
|                               |                      |               MIG M. |
|===============================+======================+======================|
|   0  NVIDIA GeForce ...  On   | 00000000:01:00.0  On |                  N/A |
| N/A   57C    P8    17W /  N/A |     54MiB / 16384MiB |     28%      Default |
|                               |                      |                  N/A |
+-------------------------------+----------------------+----------------------+

+-----------------------------------------------------------------------------+
| Processes:                                                                  |
|  GPU   GI   CI        PID   Type   Process name                  GPU Memory |
|        ID   ID                                                   Usage      |
|=============================================================================|
+-----------------------------------------------------------------------------+
```

If this is working, then it is time to build and run our docker.

### Build and test our docker

Run the script `./build.bash` to create our docker image.  This process took about 30 minutes on my PC, so get on with something else while the image is built.

The build script automatically passes your host UID and GID into the image build,
so files created in the bind-mounted workspace can be edited and deleted by your
host user without permission issues.

When the build has completed, run the commands:

```bash
./start.bash
./attach.bash
```

At this point, you should be in a terminal shell attached to the docker.  Start gazebo by typing `gazebo --verbose` and you should see gazebo start up.  I use the `--verbose` option so that I can see something happen on the terminal while Gazebo is loading.

If this is working, then you are ready to use Gazebo.

If `gz sim` reports Mesa or `iris` warnings but the simulator window opens and renders correctly, those warnings can usually be ignored.  The `start.bash` script sets `XDG_RUNTIME_DIR` for the container to avoid the common Qt runtime warning.  A quick GPU sanity check is to run `nvidia-smi` on the host before starting the container and confirm that Gazebo opens with normal rendering performance.

## Day to day usage

To start the container, use `./start.bash` which script starts the container and leaves it running until `./stop.bash` is called.  It also copies any scripts from the `~/setup` directory into the workspace directory to allow the user to setup the workspace.

After starting the container, you can get a Bash user prompt attached to the container using `./attach.bash`.  The command `source /opt/ros/foxy/setup.bash` is automatically run for each new terminal.

To stop the container, use `./stop.bash`.

If you cannot start the docker for some reason, the following command sequence normally fixes any problems.

```bash
./stop.bash
./rm_container.bash
./start.bash
./attach.bash
```

The `stop.bash` script deletes `/tmp/.docker.xauth/` that is used by the docker to communicate to the GPU.  `rm_container.bash` then deletes the container that may have been left in a strange state after a crash.  `start.bash` re-creates the container so it should all work again.

## Advanced operations

### Modifying your workspace directory

The workspace directory inside the docker is always `~/ws` and is bind mounted to an external directory when the container is created using the `start.bash` script.  The external workspace directory is set in the `./vars.bash` file and the variable used is set as follows: `WORKSPACE_DIR=${HOME}/${CONTAINER_NAME}_ws`.

To change the workspace directory, modify the `WORKSPACE_DIR` variable in `./vars.bash` and save. then run these commands:

```bash
./stop.bash
./rm_container.bash
./start.bash
./attach.bash
```

The new workspace directory should now be in use.  To test it, add a file using `touch` in the `~/ws` directory of the docker and check that it has appeared in the external directory.
