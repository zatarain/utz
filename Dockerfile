FROM zatarain/cpp:development
ENV LD_LIBRARY_PATH=/usr/local/lib \
	TERM=xterm \
	PATH=${PATH}:/build/bin
RUN echo "${TERM}" && tabs -4
VOLUME [ "/root" ]
WORKDIR /root
COPY . .
RUN make install
WORKDIR /root/aut
RUN utz test

#RUN make clean && make uninstall

#WORKDIR /
ENTRYPOINT /bin/bash