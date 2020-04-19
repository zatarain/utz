FROM zatarain/gcc:development
ENV DEBIAN_FRONTEND=noninteractive \
	LD_LIBRARY_PATH=/usr/local/lib:${LD_LIBRARY_PATH} \
	TERM=xterm \
	PATH=${PATH}:/build/bin
RUN echo "${TERM}" && tabs -4

WORKDIR /root
COPY . .
RUN make install
WORKDIR /root/aut
RUN utz run test=main

#RUN make clean && make uninstall

#WORKDIR /
ENTRYPOINT /bin/bash