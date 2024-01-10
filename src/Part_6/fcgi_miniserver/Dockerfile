FROM nginx:latest
USER root
RUN apt-get update && apt-get install -y \
    gcc \
    libfcgi-dev \
    spawn-fcgi && rm -rf /var/lib/apt/lists
COPY miniserver.c /home/
COPY run.sh /home/
WORKDIR /home/
RUN sudo chmod 777 run.sh ; \
    gcc miniserver.c -lfcgi ; \
    sudo chmod 777 a.out ; \
    touch /var/run/nginx.pid ; \
    chown -R nginx:nginx /var/run/nginx.pid ;
RUN useradd rightssh;
USER rightssh

CMD [ "sh", "./run.sh" ]