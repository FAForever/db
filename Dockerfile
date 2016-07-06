FROM mysql:5.7

RUN apt-get update && apt-get install libmysqlclient-dev

EXPOSE 3306
