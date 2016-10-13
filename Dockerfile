FROM logstash

MAINTAINER Dmitrii Zolotov <dzolotov@herzen.spb.ru>

ENV DEBIAN_FRONTEND noninteractive

RUN cd /etc/logstash && curl -O "http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz" && gunzip GeoLiteCity.dat.gz && \
    sed -i 's/0x78,0x../0x78,0x01/ig' /opt/logstash/vendor/bundle/jruby/1.9/gems/gelfd-0.2.0/lib/gelfd.rb

ADD elasticsearch-template.json /etc/logstash/templates/elasticsearch-template.json

ADD ./*.pattern ${LOGSTASH_HOME}/patterns/

ADD *.conf /etc/logstash/conf.d/

EXPOSE 5000 5044 12201/udp 12202/udp

