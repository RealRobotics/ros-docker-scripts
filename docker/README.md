# Docker

[Back to top](../README) | [GPU-accelerated version](../nvidia_docker/README.md)

This directory provides scripts to quickly build and run ROS 2 projects in a standard Docker container. Scripts are provided to create the Docker image, start and stop containers, and attach terminal shells to running containers. Docker installation tools are also included.

## Basic operation

If you don't already have docker, install it using:

```bash
cd docker
./install_docker.bash
docker --version
```

If the version number and build are shown, then docker is installed correctly.

Now build the docker image.

```bash
cd docker
./build.bash
```

This creates the docker image.  Do this just once!

The build script automatically passes your host UID and GID into the image build,
so files created in the bind-mounted workspace can be edited and deleted by your
host user without permission issues.

Then start a docker container using the image that we have just built.

```bash
cd docker
./start.bash
```

The docker container is now running in the background.  The next thing to do
is to attach a terminal shell to it so we can build our code.

```bash
cd docker
./attach.bash
```

You should see a prompt starting with `ubuntu@`, e.g.

```bash
ubuntu@andy-Precision-7510:~
```

The `./attach.bash` script can be used multiple times on the same docker
container, so that you can run a server in one shell and a client in another
shell.

When you enter the docker shell, the user is `ubuntu`, and the default directory is `~/ws` which is bind mounted to the workspace directory.

When you have finished using your shell, simply type `exit`.

Your docker container will still be running until you either:

* shutdown your PC or VM
* Use the command:

    ```bash
    cd docker
    ./stop.bash
    ```

## Notes on using docker

__Important__ When the docker container is stopped, any changes made to the
container are lost.  Only the changes to files in the workspace directory are
retained as they exist outside of the docker and are only mounted.

When docker is installed, the docker images and containers are stored in a
special location on your PC/VM.  There are a whole bunch of commands that
you can use.  Try typing `docker --help` to get an idea of the basics.

## Notes on the scripts

The `build.bash` script passes your host user id (UID) and group id (GID) into the image build, so files created in the mounted workspace can be edited and deleted by your host user without permission issues.

The `start.bash` script creates the workspace directory in your home directory.  This directory is shared (bind mounted) with the docker where it appears as `~/ws`.

If you want to change where the workspace directory is created, modify the `WORKSPACE_DIR` variable in `vars.bash`, then stop and delete the current container using `./rm_container.bash` and start a new container using `./start.bash`.
