FROM opensuse:42.3
LABEL maintainer Sergio Lindo Mansilla <slindomansilla@suse.com>
LABEL version="4.5.1509097496.8b8e8e20"

# At the moment, the only reliable source repository to install openQA is its
# devel project in OBS.
RUN zypper ar -f obs://devel:openQA/openSUSE_Leap_42.3 openQA
RUN zypper ar -f obs://devel:openQA:Leap:42.3/openSUSE_Leap_42.3 openQA-perl-modules
RUN zypper --gpg-auto-import-keys ref
RUN zypper --non-interactive in --force-resolution apache2
RUN zypper --non-interactive in --force-resolution openQA

RUN a2enmod headers
RUN a2enmod proxy
RUN a2enmod proxy_http
RUN a2enmod proxy_wstunnel

RUN cp /etc/apache2/vhosts.d/openqa.conf.template /etc/apache2/vhosts.d/openqa.conf

# This script start the services without having dbus.
ADD run_openqa.sh /root/
RUN chmod +x /root/run_openqa.sh

EXPOSE 80 443
CMD ["/bin/bash"]
