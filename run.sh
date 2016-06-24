#!/bin/bash

if [ ! -d "$1" ]; then
	echo "Directory parameter omitted! Mounting current working directory as volume..."
	directory="`pwd`"
else
	echo "Mounting directory $1 as volume..."
	directory="$1"
fi

# if you DID NOT enable nvidia-docker
#docker run -d --name="graphlab" -v "${directory}:/data" --net=host graphlab:latest

# or to run with the special GPU-enabled nvidia-docker
nvidia-docker run -d --name="graphlab" -v="${directory}:/data" --net=host graphlab:latest
