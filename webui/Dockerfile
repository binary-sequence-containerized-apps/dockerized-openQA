FROM opensuse:tumbleweed
LABEL maintainer Sergio Lindo Mansilla <slindomansilla@suse.com>
LABEL version="2017-11-25"

RUN zypper --gpg-auto-import-keys ref
RUN zypper --non-interactive in --force-resolution apache2
RUN zypper --non-interactive in --force-resolution w3m
RUN zypper --non-interactive in --force-resolution which
RUN zypper --non-interactive in --force-resolution openQA

RUN a2enmod headers
RUN a2enmod proxy
RUN a2enmod proxy_http
RUN a2enmod proxy_wstunnel

# Config
RUN mkdir -p /run/dbus
RUN echo ServerName localhost >> /etc/apache2/httpd.conf
RUN cp /etc/apache2/vhosts.d/openqa.conf.template /etc/apache2/vhosts.d/openqa.conf
ADD client.conf /etc/openqa/
ADD openqa.ini /etc/openqa/
ADD rsyncd.conf /etc/

# This script starts the necessary services.
ADD run_openqa.sh /root/
RUN chmod +x /root/run_openqa.sh

EXPOSE 80 443 873
CMD ["/root/run_openqa.sh"]
