This repository contains support files to install the Inferno testing tool onto an AWS EC2 instance. 

# Overlay Structure

The service is designed to run in several docker containers: one for the Ruby server itself and one for the NGNIX instance that fronts the Ruby server. These are connected through a `docker-compose.yml` script. This script creates the two machines and connects them together. The script also maps several files from both the core repository as well as the overlay repository into the running docker images. 

The core Inferno project is loaded through a git submodule. This submodule is tied to the repository on GitHub and can be updated to contain the latest checkout of the `master` branch using the submodule update commands below.

The project contains a `Makefile` which allows simpler execution of commands in the setup guide. It's not required to use this file and the direct commands are available by reading the `Makefile`. 

The files in `static-assets` are served directly by the NGINX server and are not available to the Ruby server. This directory is mapped by the docker compose file. These files are all under the `site/` directory within here to avoid conflicts with the main application.

The files in `site-overlay` are mapped into the Ruby server and become part of the running ruby application. These files are mapped individually by the docker compose file.

# Loading from AMI

An AMI of this image with everything configured is available from the development team. This AMI has been configured as below. If you're building from the existing AMI, start from the "Set Up The Server" section below.

# Building the Server

If you want to build the EC2 instance from scratch, follow these directions to install the required support software and get everything up and running.

## Create the EC2 Image

Create a new EC2 image per Amazon's instructions. Update it to the latest version. The rest of these instructions assume the Amazon Linux distribution. We used a micro image for the demo installation.

## Install Docker

Docker is not installed on the EC2 image by default but it is available from the built-in repositories.

`sudo yum install docker -y`

Follow the instructions [from AWS](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/docker-basics.html#install_docker) to complete setting up Docker.

## Install Docker Compose

Docker Compose is not installed with the Docker tool but it is available from the `pip` library.

`sudo pip install docker-compose`

## Install Git

The code is available from git. Git needs to be installed on the Amazon image before you can use it. 

`sudo yum install git -y`

## Download the Overlay

The overlay code is available from this git repository: https://github.com/siteadmin/inferno-site-overlay.git(https://github.com/siteadmin/inferno-site-overlay.git). 

`git clone https://github.com/siteadmin/inferno-site-overlay.git`

Note that downloading an export of the repository is not recommended as the submodule is not properly included in an export.

The rest of these commands are from inside of the checkout directory.

`cd inferno-site-overlay`

# Set Up the Server

Once the required server environment has been set up, the server needs to be built and deployed.

## Update the Submodule

Before the project can be built or run, the code for the Inferno project needs to be pulled into the submodule directory and checked out. 

`make git_update`

## Build the Inferno Docker Support Image

The Ruby server has a custom docker image containing all the dependencies for the Inferno project that needs to be built before the server is run. This image does not contain the code for the application, this is mapped at runtime.

`make inferno_docker_build`

Docker will cache the build of this image and make it available to docker-compose for later steps. To force a rebuild of the image, run this command instead.

`make inferno_docker_rebuild`

## Start the Server

The server can be started by using docker compose, which boots both the Ruby server and the NGINX server to front it. 

`docker-compose up -d`

This starts the servers in the background (detatched).

To stop the servers, run:

`docker-compose down`

## Updating the Server

The overlay can be updated by pulling from the git repository where it was first downloaded.

`git pull`

From here, follow the instructions to update the submodule, build the docker image, and start the server as above.