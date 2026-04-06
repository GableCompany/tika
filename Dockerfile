FROM maven:3.9.9-eclipse-temurin-17 AS build

WORKDIR /workspace

COPY . .

RUN set -eux; \
    mvn -pl tika-server/tika-server-standard -am -DskipTests package; \
    bin_zip="$(ls tika-server/tika-server-standard/target/tika-server-standard-*-bin.zip | head -n 1)"; \
    mkdir -p /opt/tika; \
    cd /opt/tika; \
    jar xf "/workspace/${bin_zip}"

FROM eclipse-temurin:17-jre

WORKDIR /app

COPY --from=build /opt/tika/ /app/
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

RUN chmod +x /usr/local/bin/docker-entrypoint.sh

EXPOSE 9998

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
