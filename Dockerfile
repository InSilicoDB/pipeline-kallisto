FROM ubuntu:15.10


RUN apt-get update  && apt-get install -y \
		build-essential \
		cmake \
		python \
		python-pip \
		python-dev \
		hdf5-tools \
		libhdf5-dev \
		hdf5-helpers \
		libhdf5-serial-dev \
		git

WORKDIR /root
RUN git clone https://github.com/pachterlab/kallisto.git 
WORKDIR /root/kallisto
RUN mkdir build
WORKDIR /root/kallisto/build 
RUN cmake .. && \
	make && \
	make install