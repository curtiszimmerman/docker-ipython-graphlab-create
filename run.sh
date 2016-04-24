#!/bin/bash

# if you DID NOT enable nvidia-docker
#docker run -d --name="graphlab" -v "`pwd`/data:/data" -p 8888:8888 graphlab:latest

# or to run with the special GPU-enabled nvidia-docker
nvidia-docker run -d --name="graphlab" -v="`pwd`/data:/data" -p 8888:8888 graphlab:latest
