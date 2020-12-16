FROM golang:1.8-alpine


RUN mkdir -p /home/LogFiles /opt/startup \
     && echo "root:Docker!" | chpasswd \
     && echo "cd /home" >> /etc/bash.bashrc \
     && apk update \  
     && apk add openssh vim curl wget tcptraceroute openrc

RUN rm -f /etc/ssh/sshd_config
RUN mkdir -p /tmp
COPY ssh_setup.sh /tmp
COPY startup /opt/startup
COPY sshd_config /etc/ssh/

RUN chmod -R +x /opt/startup \
   && chmod -R +x /tmp/ssh_setup.sh \
   && (sleep 1;/tmp/ssh_setup.sh 2>&1 > /dev/null) \
   && rm -rf /tmp/* \
   && cd /opt/startup
RUN apk add --no-cache --upgrade bash

WORKDIR /go/src/basic-go-server
COPY . .
RUN go-wrapper download
RUN go-wrapper install

ENV PORT=8080
ENV PORT_SSH=2222
EXPOSE $PORT $PORT_SSH

#CMD ["go-wrapper", "run"]
ENTRYPOINT ["/opt/startup/init_container.sh"]
