FROM google/golang:1.2

ENV GOPATH $GOPATH:/gopath/src/github.com/docker/libcontainer/vendor
WORKDIR /gopath/src/github.com/Yelp/dockersh
ADD . /gopath/src/github.com/Yelp/dockersh/
RUN git clone -b v1.2.0 https://github.com/docker/libcontainer.git \
	/gopath/src/github.com/docker/libcontainer
RUN git clone -b v1.7.1 https://github.com/docker/docker.git \
	/gopath/src/github.com/docker/docker
RUN go get
RUN make dockersh && chmod 755 /gopath/src/github.com/Yelp/dockersh/installer.sh && ln /gopath/src/github.com/Yelp/dockersh/dockersh /dockersh && chown root:root dockersh && chmod u+s dockersh

CMD ["/gopath/src/github.com/Yelp/dockersh/installer.sh"]

