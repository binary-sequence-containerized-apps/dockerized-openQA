FROM opensuse:42.3
LABEL maintainer Sergio Lindo Mansilla <slindomansilla@suse.com>
LABEL version="2017-11-15"

# At the moment, the only reliable source repository to install openQA is its
# devel project in OBS.
RUN zypper ar -f obs://devel:openQA/openSUSE_Leap_42.3 devel-openQA
RUN zypper ar -f obs://devel:openQA:Leap:42.3/openSUSE_Leap_42.3 devel-openQA-perl-modules
RUN zypper --gpg-auto-import-keys ref
RUN zypper --non-interactive in --force-resolution apache2
RUN zypper --non-interactive in --force-resolution perl-Archive-Extract
RUN zypper --non-interactive in --force-resolution w3m
RUN zypper --non-interactive in --force-resolution which
RUN zypper --non-interactive in --force-resolution openQA
RUN a2enmod headers
RUN a2enmod proxy
RUN a2enmod proxy_http
RUN a2enmod proxy_wstunnel

# Config
RUN mkdir -p /run/dbus
RUN echo ServerName locahost >> /etc/apache2/httpd.conf
RUN cp /etc/apache2/vhosts.d/openqa.conf.template /etc/apache2/vhosts.d/openqa.conf
ADD openqa.ini /etc/openqa/openqa.ini
ADD rsyncd.conf /etc/rsyncd.conf

# This script start the necessary services.
ADD run_openqa.sh /root/
RUN chmod +x /root/run_openqa.sh

EXPOSE 80 443 873
CMD ["/root/run_openqa.sh"]
