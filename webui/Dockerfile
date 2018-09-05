FROM opensuse/tumbleweed
LABEL maintainer Sergio Lindo <sergiolindo.empresa@gmail.com>
LABEL version="2018-09-06"

RUN zypper --gpg-auto-import-keys ref
RUN zypper --non-interactive install --force-resolution apache2
RUN zypper --non-interactive install --force-resolution perl-DateTime-Format-Pg
RUN zypper --non-interactive install --force-resolution perl-DBD-Pg
RUN zypper --non-interactive install --force-resolution postgresql
RUN zypper --non-interactive install --force-resolution postgresql-server
RUN zypper --non-interactive install --force-resolution w3m
RUN zypper --non-interactive install --force-resolution which
RUN zypper --non-interactive install --force-resolution openQA

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
ADD rsyncd.conf /etc/

# This script starts the necessary services.
ADD run_openqa.sh /root/
RUN chmod +x /root/run_openqa.sh

EXPOSE 80 443 873
CMD ["/root/run_openqa.sh"]
