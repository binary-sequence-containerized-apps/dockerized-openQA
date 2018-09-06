#!/bin/bash

export DBUS_STARTER_BUS_TYPE=system

# prepare environment
rm -f /run/dbus/pid

# run services
dbus-daemon --system --fork
start_daemon -u postgres  /usr/share/postgresql/postgresql-script start &
start_daemon -u geekotest /usr/share/openqa/script/openqa-resource-allocator &
start_daemon -u geekotest /usr/share/openqa/script/openqa-scheduler &
start_daemon -u geekotest /usr/share/openqa/script/openqa-websockets &
start_daemon -u geekotest /usr/share/openqa/script/openqa gru -m production run &
apache2ctl start
start_daemon -u geekotest /usr/share/openqa/script/openqa prefork -m production --proxy
