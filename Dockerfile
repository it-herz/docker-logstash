FROM logstash:latest

MAINTAINER Dmitrii Zolotov <dzolotov@herzen.spb.ru>

ENV DEBIAN_FRONTEND noninteractive

RUN cd /etc/logstash && curl -O "http://geolite.maxmind.com/download/geoip/database/GeoLite2-City.mmdb.gz" && gunzip GeoLite2-City.mmdb.gz && \
    sed -i 's/0x78,0x../0x78,0x01/ig' /usr/share/logstash/vendor/bundle/jruby/1.9/gems/gelfd-0.2.0/lib/gelfd.rb

ADD elasticsearch-template.json /etc/logstash/templates/elasticsearch-template.json

ADD ./*.pattern /usr/share/logstash/patterns/
ADD ./nginx /usr/share/logstash/patterns/

ADD *.conf /etc/logstash/conf.d/

EXPOSE 5000 5044 12201/udp 12202/udp

Fix CMD [ "-f", "/etc/logstash/conf.d" ]
