FROM alpine
LABEL maintainer="jeferson@linuxtips.com.br"
LABEL version="1.0"

ENV alertmanager_version alertmanager-0.11.0.linux-amd64

WORKDIR /alertmanager

RUN apk --no-cache add curl \
    && curl -LO https://github.com/prometheus/alertmanager/releases/download/v0.11.0/${alertmanager_version}.tar.gz \
    && tar -xvzf ${alertmanager_version}.tar.gz \
    && cp ${alertmanager_version}/alertmanager /bin \
    && rm -rf ${alertmanager_version}

VOLUME /alertmanager
VOLUME /etc/alertmanager
ADD conf/config.yml /etc/alertmanager/
ENTRYPOINT ["alertmanager"] 
CMD ["-config.file=/etc/alertmanager/config.yml", "-storage.path=/alertmanager"]
EXPOSE 9093


