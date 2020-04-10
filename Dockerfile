FROM gcc:9.3.0
ENV DEBIAN_FRONTEND=noninteractive \
	LD_LIBRARY_PATH=/usr/local/lib:${LD_LIBRARY_PATH} \
	TERM=xterm \
	PATH=${PATH}:/build/bin
RUN echo "${TERM}" && tabs -4

WORKDIR /build
COPY src src
COPY examples examples
COPY Makefile ./

RUN make all && make install && make test

#RUN make clean && make uninstall

WORKDIR /
ENTRYPOINT /bin/sh