FROM flyway/flyway:7.15.0-alpine

ENV FLYWAY_EDITION community

COPY migrations /flyway/sql/
