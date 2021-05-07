FROM debian:stable-slim

ENV PATH=/opt/bitcoin-0.21.1/bin:$PATH

RUN apt-get update -y \
  && apt-get install -y curl gosu \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
# 
RUN curl -SLO https://bitcoin.org/bin/bitcoin-core-0.21.1/bitcoin-0.21.1-x86_64-linux-gnu.tar.gz \
  && tar -xzf *.tar.gz -C /opt \
  && rm *.tar.gz

COPY docker-entrypoint.sh /entrypoint.sh

RUN chmod a+x /entrypoint.sh

VOLUME ["/home/bitcoin/.bitcoin"]

EXPOSE 18443 18444 28334 28335

ENTRYPOINT ["/entrypoint.sh"]

CMD ["bitcoind"]