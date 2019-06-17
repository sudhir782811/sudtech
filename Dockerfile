FROM ubuntu:16.04
LABEL maintainer='sudhir' \
	epmployee_name='sudhir' \
	version=1.0.0
RUN apt-get update -y
RUN apt-get install apache2 -y
RUN apt-get install wget -y
RUN apt-get install unzip -y

WORKDIR /tmp
RUN wget https://github.com/sudhir782811/sudtech/archive/master.zip
RUN unzip master.zip
RUN mv sudtech-master/* /var/www/html/
EXPOSE 80
CMD ["apachectl", "-D", "FOREGROUND"]
