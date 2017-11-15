FROM opensuse:42.3
LABEL maintainer Sergio Lindo Mansilla <slindomansilla@suse.com>
LABEL version="2017-11-15"

# At the moment, the only reliable source repository to install openQA is its
# devel project in OBS.
RUN zypper ar -f obs://devel:openQA/openSUSE_Leap_42.3 devel-openQA
RUN zypper ar -f obs://devel:openQA:Leap:42.3/openSUSE_Leap_42.3 devel-openQA-perl-modules
RUN zypper --gpg-auto-import-keys ref
RUN zypper --non-interactive in openQA-worker

ADD client.conf /etc/openqa/
ADD workers.ini /etc/openqa/

USER _openqa-worker
CMD ["/usr/share/openqa/script/worker", "--verbose", "--instance", "1"]
