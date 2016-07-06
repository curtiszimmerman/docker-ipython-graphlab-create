

FROM ubuntu:14.04
MAINTAINER curtiszimmerman <software@curtisz.com>

# get the things we need
RUN apt-get update -y && \
	apt-get install -y \
		curl \
		python-qt4 && \
	rm -rf /var/cache/apt/archive/*

# get more things we need (and do it on one layer so our unionfs doesn't store the 400mb file in one of its layers)
WORKDIR /tmp
RUN curl -o /tmp/Anaconda2-4.0.0-Linux-x86_64.sh http://repo.continuum.io/archive/Anaconda2-4.0.0-Linux-x86_64.sh && \
	chmod +x ./Anaconda2-4.0.0-Linux-x86_64.sh && \
	./Anaconda2-4.0.0-Linux-x86_64.sh -b && \
	rm ./Anaconda2-4.0.0-Linux-x86_64.sh
# make the anaconda stuff available
ENV PATH=${PATH}:/root/anaconda2/bin

## do some amazing anaconda things (from: https://dato.com/download/install-graphlab-create.html)
# create conda environment with python 2.7.x 
RUN conda create -n dato-env python=2.7 anaconda
# activate conda environment
RUN ["/bin/bash", "-c", ". activate dato-env"]
# ensure pip version >= 7
RUN conda update pip

## install graphlab create with creds provided in --build-arg in 'docker build' command (in build.sh):
ARG USER_EMAIL
ARG USER_KEY
RUN pip install --upgrade --no-cache-dir https://get.dato.com/GraphLab-Create/1.10.1/${USER_EMAIL}/${USER_KEY}/GraphLab-Create-License.tar.gz

## install ipython and ipython notebook
RUN conda install ipython-notebook

## NVIDIA GPU ACCELERATION IS NOT AS EASY AS YOU THINK (but still possible)
# see: https://github.com/NVIDIA/nvidia-docker/wiki/Using%20nvidia-docker-plugin
# upgrade GraphLab Create with GPU Acceleration
RUN pip install --upgrade --no-cache-dir http://static.dato.com/files/graphlab-create-gpu/graphlab-create-1.10.1.gpu.tar.gz

# and set our container's run command
CMD ["jupyter", "notebook", "--ip=0.0.0.0"]
