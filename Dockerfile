FROM zatarain/gcc:development
ENV DEBIAN_FRONTEND=noninteractive \
	LD_LIBRARY_PATH=/usr/local/lib:${LD_LIBRARY_PATH} \
	TERM=xterm \
	PATH=${PATH}:/build/bin
RUN echo "${TERM}" && tabs -4

COPY . /build
WORKDIR /build
#RUN make make install
RUN make test-example

#RUN make clean && make uninstall

WORKDIR /
ENTRYPOINT /bin/sh