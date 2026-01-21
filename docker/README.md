# Docker

[Back to top](../README.md)

This directory provides the user with a method to quickly build the ROS2
Pipebots project in a docker container.  Scripts are provided to
create the docker image and to start, stop and attach to the docker container
as well as a to install the docker tools.

## Basic operation

If you don't already have docker, install it using:

```bash
cd common
./install_docker.bash
docker --version
```

You should see the latest version of docker running.

Now build the docker image.

```bash
cd docker
./ubuntu.bash
```

This creates the docker image.  Do this just once!

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

When you are in the docker shell, the user is `ubuntu`, so you should see a prompt starting with `ubuntu@`, e.g.

```bash
ubuntu@andy-Precision-7510:~/ws$
```

The `./attach.bash` script can be used multiple times on the same docker
container, so that you can run a server in one shell and a client in another
shell.

When you have finished using your shell, simply type `exit`.

```bash
ubuntu@andy-Precision-7510:~/ws$ exit
exit
```

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

If you want to keep the changes in the docker image, say you install some
new packages, then you can use the `commit.bash` script to save the new image.
__NOTE__ If you do this, no-one else will be able to use these changes unless
you update the `dockerfile` and push the changes to the GitHub repo.

When docker is installed, the docker images and containers are stored in a
special location on your PC/VM.  There are a whole bunch of commands that
you can use.  Try typing `docker --help` to get an idea of the basics.

## Notes on the scripts

The `build.bash` script assumes that your user id (UID) and group
identity (GID) values are both equal to 1000.  This works on default
installations of Ubuntu.

The `start.bash` script creates the workspace directory `ros_kilted_ws` in
your home directory.  This directory is shared (bind mounted) with the
docker where it appears as `~/ws`.

If you want change where the workspace directory is created, change the value
`WORKSPACE_DIR` in `vars.bash`, then stop and delete the current container
using `./rm_container.bash` and then start a new container using `.start.bash`.
