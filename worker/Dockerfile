FROM opensuse:42.3
LABEL maintainer Sergio Lindo Mansilla <slindomansilla@suse.com>
LABEL version="0.3"

RUN zypper ar -f obs://devel:openQA/openSUSE_Leap_42.3 openQA && \
    zypper ar -f obs://devel:openQA:Leap:42.3/openSUSE_Leap_42.3 openQA-perl-modules && \
    zypper --gpg-auto-import-keys ref && \
    zypper --non-interactive in openQA-worker
ADD client.conf /etc/openqa/client.conf

USER _openqa-worker
RUN /usr/share/openqa/script/worker --verbose --instance 1
