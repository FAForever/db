FROM boxfuse/flyway:5.2-alpine

ENV FLYWAY_EDITION community

COPY migrations /flyway/sql/
