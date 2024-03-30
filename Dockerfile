FROM debian:bookworm-slim
LABEL maintainer="Feng Honglin <hfeng@tutum.co>"

RUN apt-get update && \
    apt-get -y --no-install-recommends install openssh-server autossh pwgen sshpass fail2ban && \
    apt-get clean && \
    mkdir -p /var/run/sshd && \
    mkdir -p /root/.ssh && \
    sed -i '/.*UsePrivilegeSeparation.*/s/^/# /' /etc/ssh/sshd_config && \
    sed -i '/.*UsePAM.*/s/^/# /' /etc/ssh/sshd_config && \
    sed -i '/.*PermitRootLogin.*/s/^/# /' /etc/ssh/sshd_config && \
    sed -i '/.*GatewayPorts.*/s/^/# /' /etc/ssh/sshd_config && \
    echo '# Docker configuration' >> /etc/ssh/sshd_config && \
    echo 'UsePrivilegeSeparation no' >> /etc/ssh/sshd_config && \
    echo 'UsePAM no' >> /etc/ssh/sshd_config && \
    echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config && \
    echo 'GatewayPorts yes' >> /etc/ssh/sshd_config && \
    rm -rf /var/lib/apt/lists/*

ADD run.sh /run.sh
RUN chmod +x /*.sh

ENV AUTHORIZED_KEYS **None**
ENV ROOT_PASS **None**
ENV PUBLIC_HOST_ADDR **None**
ENV PUBLIC_HOST_PORT **None**
ENV PROXY_PORT **None**

EXPOSE 22
EXPOSE 1080

CMD ["/run.sh"]
