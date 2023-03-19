FROM flyway/flyway:9.16-alpine

ENV FLYWAY_EDITION community

COPY migrations /flyway/sql/
