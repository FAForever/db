FROM flyway/flyway:7.5-alpine

ENV FLYWAY_EDITION community

COPY migrations /flyway/sql/
