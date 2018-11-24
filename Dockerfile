FROM arm32v6/alpine:latest
RUN apk add --no-cache curl perl
WORKDIR /app
ADD https://fhem.de/fhem-5.9.tar.gz .
RUN tar -xzf fhem*.tar.gz && \
	rm -rf fhem*.tar.gz && \
	mv fhem* fhem

WORKDIR /app/fhem
VOLUME /app/config

EXPOSE 8083 8084 8085

HEALTHCHECK --interval=30s --timeout=10s CMD curl -fL http://localhost:8083

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]