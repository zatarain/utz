FROM gcc:9.3.0
ENV DEBIAN_FRONTEND noninteractive
ENV LD_LIBRARY_PATH=/usr/local/lib:${LD_LIBRARY_PATH}
ENV TERM=xterm
RUN echo "${TERM}"
RUN tabs -4

COPY ./src /build/src
COPY ./Makefile /build/
COPY ./examples /build/examples
WORKDIR /build

RUN make all && make install && make test
ENV PATH=${PATH}:/build/bin

#RUN make clean && make uninstall

WORKDIR /
ENTRYPOINT /bin/sh