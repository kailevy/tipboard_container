FROM ubuntu:latest

RUN apt-get update
RUN apt-get install -y python-dev python-pip redis-server supervisor

COPY supervisord.conf /etc/supervisor/supervisord.conf

COPY tipboard /root/.tipboard

USER root

RUN pip install tipboard

COPY settings.py /usr/local/lib/python2.7/dist-packages/tipboard/settings.py
COPY tipboard.js /usr/local/lib/python2.7/dist-packages/tipboard/static/js/tipboard.js

EXPOSE 7272

CMD ["/usr/bin/supervisord","-c","/etc/supervisor/supervisord.conf"]