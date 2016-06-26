FROM alpine
ENV RETAWQ_VERSION=0.2.6c
ENV RETAWQ_MD5=ee60188bea597680bd39e435a8c73ff9
ENV RETAWQ=retawq-$RETAWQ_VERSION
ENV RETAWQ_URL=http://downloads.sourceforge.net/project/retawq/retawq/$RETAWQ/$RETAWQ.tar.gz
WORKDIR /tmp
RUN apk update
RUN apk add build-base \
            wget \
            ncurses-dev \
            openssl-dev
RUN wget -O "/tmp/$RETAWQ.tar.gz" "$RETAWQ_URL"
RUN echo "$RETAWQ_MD5 *$RETAWQ.tar.gz" | md5sum -c
RUN tar -xzf "$RETAWQ.tar.gz"
WORKDIR /tmp/$RETAWQ
RUN ./configure --set-tls=2
RUN make
RUN make install
WORKDIR /
RUN rm -rf /tmp/$RETAWQ-*
ENTRYPOINT ["retawq"]
