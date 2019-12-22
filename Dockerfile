FROM alpine:3.11 as packager

LABEL maintainer="sl.dockerdev@sylvain.lv"

RUN apk add --no-cache iperf3
RUN echo "nobody:x:65534:65534:Nobody:/:" > /passwd.minimal

FROM scratch

ENV LD_LIBRARY_PATH /usr/lib:/lib

USER nobody

COPY --from=packager --chown=65534:65534 /tmp /tmp
COPY --from=packager /passwd.minimal /etc/passwd
COPY --from=packager /lib/ld-musl-aarch64.so.1 /lib/ld-musl-aarch64.so.1
COPY --from=packager /usr/lib/libiperf.so.0 /usr/lib/libiperf.so.0
COPY --from=packager /usr/bin/iperf3 /usr/bin/iperf3

EXPOSE 5201/tcp 5201/udp

ENTRYPOINT ["/usr/bin/iperf3"]
CMD ["-s"]
