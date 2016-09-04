FROM gcr.io/stacksmith-images/ubuntu:14.04-r9

MAINTAINER Bitnami <containers@bitnami.com>

ENV BITNAMI_APP_NAME=phpbb \
    BITNAMI_IMAGE_VERSION=3.1.9-r1 \
    PATH=/opt/bitnami/mysql/bin/:/opt/bitnami/php/bin/:$PATH

# Additional modules required
RUN bitnami-pkg unpack apache-2.4.23-2 --checksum be3c28581f363e240f04c2d32bcf2d4a5ea0926722bb23ab9f5dfb38bde22bac
RUN bitnami-pkg install php-5.6.25-0 --checksum f0e8d07d155abdb5d6843931d3ffbf9b4208fff248c409444fdd5a8e3a3da01d
RUN bitnami-pkg install libphp-5.6.21-2 --checksum 83d19b750b627fa70ed9613504089732897a48e1a7d304d8d73dec61a727b222
RUN bitnami-pkg install mysql-client-10.1.13-4 --checksum 14b45c91dd78b37f0f2366712cbe9bfdf2cb674769435611955191a65dbf4976

# Install phpbb
RUN bitnami-pkg unpack phpbb-3.1.9-0 --checksum 440c119a357bb08e86e3bc184026482dea8e1780f65e28d50cf6e743dbd3e60d

COPY rootfs /

VOLUME ["/bitnami/phpbb", "/bitnami/apache", "/bitnami/php"]

EXPOSE 80 443

ENTRYPOINT ["/app-entrypoint.sh"]

CMD ["nami", "start", "--foreground", "apache"]
