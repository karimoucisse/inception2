FROM debian:12.12

RUN apt-get -y update && apt-get -y upgrade && \
	apt-get -y install curl procps
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
COPY server /server
COPY deezer /deezer

COPY conf/test.sh /test.sh
RUN chmod +x /test.sh
ENTRYPOINT [ "/test.sh" ]
