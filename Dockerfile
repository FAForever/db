FROM mysql:5.7.18

ENV FLYWAY_VERSION 4.0.3

# Install mysql_config which allows to set up a no-password login with --login-path
RUN apt-get update -y > /dev/null && apt-get install -y libmysqlclient-dev wget > /dev/null

# Download flyway
RUN wget -q http://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/${FLYWAY_VERSION}/flyway-commandline-${FLYWAY_VERSION}-linux-x64.tar.gz \
    && tar xzf flyway-commandline-${FLYWAY_VERSION}-linux-x64.tar.gz \
    && rm flyway-commandline-${FLYWAY_VERSION}-linux-x64.tar.gz \
    && mv flyway-${FLYWAY_VERSION} flyway \
    && chmod +x flyway/flyway
RUN chown -R mysql /flyway

# Download MariaDB driver (compatible with MySQL but supports local sockets
RUN wget -q http://search.maven.org/remotecontent?filepath=org/mariadb/jdbc/mariadb-java-client/1.5.7/mariadb-java-client-1.5.7.jar -O flyway/drivers/mariadb-java-client-1.5.7.jar
# Download JNA which is needed for local socket support of the MariaDB driver
RUN wget -q http://search.maven.org/remotecontent?filepath=net/java/dev/jna/jna/4.3.0/jna-4.3.0.jar -O flyway/drivers/jna-4.3.0.jar

COPY healthcheck.sh /
RUN chmod +x healthcheck.sh

HEALTHCHECK --interval=30s --timeout=5s --retries=5 CMD ["./healthcheck.sh"]

# Copy init scripts which will be executed automatically if the database doesn't exist yet
COPY init/* /docker-entrypoint-initdb.d/
RUN chmod +x /docker-entrypoint-initdb.d/*.sh

# Copy migration scripts
COPY migrate.sh /
RUN chmod +x migrate.sh
COPY migrations/* /flyway/sql/

# Copy dump script
COPY dump-structure.sh /
RUN chmod +x dump-structure.sh

# Copy test data for CI
COPY test-data.sql /

EXPOSE 3306
