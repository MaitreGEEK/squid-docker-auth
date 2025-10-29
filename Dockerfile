FROM debian:trixie-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    squid \
    apache2-utils \
    && rm -rf /var/lib/apt/lists/*

RUN addgroup --system squid && adduser --system --ingroup squid squid

RUN mkdir -p /var/cache/squid && chown squid:squid /var/cache/squid

COPY squid.conf /etc/squid/squid.conf
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 3128

ENTRYPOINT ["/entrypoint.sh"]
