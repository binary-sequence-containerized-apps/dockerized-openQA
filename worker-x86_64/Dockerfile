FROM opensuse:tumbleweed
LABEL maintainer Sergio Lindo Mansilla <slindomansilla@suse.com>
LABEL version="2018-06-15"

RUN zypper --gpg-auto-import-keys ref
RUN zypper --non-interactive in qemu-kvm
RUN zypper --non-interactive in openQA-worker

# Config
ADD client.conf /etc/openqa/
ADD workers.ini /etc/openqa/

USER _openqa-worker
CMD ["/usr/share/openqa/script/worker", "--verbose", "--instance", "1"]
