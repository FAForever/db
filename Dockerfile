FROM mysql:5.7

RUN apt-get update -y > /dev/null && apt-get install -y libmysqlclient-dev > /dev/null

EXPOSE 3306
