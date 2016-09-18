FROM mysql:5.7

ENV FLYWAY_VERSION 4.0.3

RUN apt-get update -y > /dev/null && apt-get install -y libmysqlclient-dev wget > /dev/null

# Download flyway
RUN wget -q http://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/${FLYWAY_VERSION}/flyway-commandline-${FLYWAY_VERSION}-linux-x64.tar.gz \
    && tar xzf flyway-commandline-${FLYWAY_VERSION}-linux-x64.tar.gz \
    && rm flyway-commandline-${FLYWAY_VERSION}-linux-x64.tar.gz \
    && mv flyway-${FLYWAY_VERSION} flyway \
    && chmod +x flyway/flyway

# Download mysql driver
RUN wget -q http://search.maven.org/remotecontent?filepath=mysql/mysql-connector-java/6.0.4/mysql-connector-java-6.0.4.jar -O flyway/drivers/mysql-connector-java-6.0.4.jar

EXPOSE 3306
