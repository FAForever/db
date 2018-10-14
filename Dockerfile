FROM boxfuse/flyway:5.2.0-alpine

ENV FLYWAY_EDITION community

COPY migrations /flyway/sql/