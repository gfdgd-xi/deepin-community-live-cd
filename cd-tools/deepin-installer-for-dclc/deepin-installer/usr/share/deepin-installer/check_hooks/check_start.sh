#!/bin/bash

. "/deepin-installer/basic_utils.sh"

exec_check "/deepin-installer/in_check/"

# logout to run lightdm-stop.sh
qdbus --system --literal org.freedesktop.login1 /org/freedesktop/login1/session/self org.freedesktop.login1.Session.Terminate
