FROM opensuse/tumbleweed
LABEL maintainer Sergio Lindo <sergiolindo.empresa@gmail.com>
LABEL version="2018-09-07"

RUN zypper --gpg-auto-import-keys ref && \
    zypper --non-interactive install --force-resolution apache2 && \
    rm -rf /var/cache/zypp/*
RUN zypper --gpg-auto-import-keys ref && \
    zypper --non-interactive install --force-resolution perl-DateTime-Format-Pg && \
    rm -rf /var/cache/zypp/*
RUN zypper --gpg-auto-import-keys ref && \
    zypper --non-interactive install --force-resolution perl-DBD-Pg && \
    rm -rf /var/cache/zypp/*
RUN zypper --gpg-auto-import-keys ref && \
    zypper --non-interactive install --force-resolution postgresql && \
    rm -rf /var/cache/zypp/*
RUN zypper --gpg-auto-import-keys ref && \
    zypper --non-interactive install --force-resolution postgresql-server && \
    rm -rf /var/cache/zypp/*
RUN zypper --gpg-auto-import-keys ref && \
    zypper --non-interactive install --force-resolution w3m && \
    rm -rf /var/cache/zypp/*
RUN zypper --gpg-auto-import-keys ref && \
    zypper --non-interactive install --force-resolution which && \
    rm -rf /var/cache/zypp/*
RUN zypper --gpg-auto-import-keys ref && \
    zypper --non-interactive install --force-resolution openQA && \
    rm -rf /var/cache/zypp/*

RUN a2enmod headers
RUN a2enmod proxy
RUN a2enmod proxy_http
RUN a2enmod proxy_wstunnel

# Config
RUN mkdir --parents /run/dbus
RUN echo ServerName localhost >> /etc/apache2/httpd.conf
RUN cp /etc/apache2/vhosts.d/openqa.conf.template /etc/apache2/vhosts.d/openqa.conf
USER postgres
RUN /usr/share/postgresql/postgresql-script start && \
    createuser geekotest && \
    createdb openqa && \
    psql --command='GRANT ALL PRIVILEGES ON DATABASE openqa TO geekotest;' && \
    /usr/share/postgresql/postgresql-script stop
USER root
ADD client.conf /etc/openqa/
ADD database.ini /etc/openqa
ADD openqa.ini /etc/openqa/

# This script starts the necessary services.
ADD run_openqa.sh /root/
RUN chmod +x /root/run_openqa.sh

EXPOSE 80 443
VOLUME [ "/var/lib/openqa/share/factory/" ]
VOLUME [ "/var/lib/openqa/testresults/" ]
VOLUME [ "/var/lib/pgsql/data/" ]
CMD ["/root/run_openqa.sh"]
