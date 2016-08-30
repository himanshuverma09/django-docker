FROM ubuntu:latest

# Set the file maintainer (your name - the file's author)
MAINTAINER Himanshu Verma

# Set env variables used in this Dockerfile (add a unique prefix, such as DOCKYARD)
ENV DOCKYARD_SRC=Project
# Directory in container for all project files
ENV DOCKYARD_SRVHOME=/home
# Directory in container for project source files
ENV DOCKYARD_SRVPROJ=/home/Project
# Update the default application repository sources list

RUN apt-get update
RUN apt-get install -y python python-pip

# Create application subdirectories
WORKDIR $DOCKYARD_SRVHOME
RUN mkdir media static logs
VOLUME ["$DOCKYARD_SRVHOME/media/", "$DOCKYARD_SRVHOME/logs/"]


COPY $DOCKYARD_SRC $DOCKYARD_SRVPROJ
# Install Python dependencies
RUN pip install -r $DOCKYARD_SRVPROJ/requirements.txt

# Port to expose
EXPOSE 8000

# Copy entrypoint script into the image
WORKDIR $DOCKYARD_SRVPROJ
COPY ./entry-point.sh /
ENTRYPOINT ["/entry-point.sh"]
