FROM opensuse:tumbleweed
LABEL maintainer Sergio Lindo Mansilla <slindomansilla@suse.com>
LABEL version="2017-12-11"

RUN zypper --gpg-auto-import-keys ref
RUN zypper --non-interactive in qemu-kvm
RUN zypper --non-interactive in openQA-worker

# Config
RUN mkdir /var/lib/openqa/share
ADD client.conf /etc/openqa/
ADD workers.ini /etc/openqa/

USER _openqa-worker
CMD ["/usr/share/openqa/script/worker", "--verbose", "--instance", "1"]
