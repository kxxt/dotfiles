#!/bin/bash

# References:
# - https://liolok.com/run-desktop-app-with-systemd-nspawn-container/
# - https://yhndnzj.com/2020/03/16/steam-on-systemd-nspawn/

BOOT_FLAGS=""

if [[ "$BOOT" != "" ]]; then
    BOOT_FLAGS="--boot"
fi

binds=(
    # X11
    --bind-ro=/tmp/.X11-unix
    # Pulse
    --bind-ro=/run/user/$UID/pulse
    # GPU
    --bind=/dev/dri
    # Nvidia
    --bind=/dev/nvidia0
    --bind=/dev/nvidiactl
    --bind=/dev/nvidia-modeset
    --bind=/dev/nvidia-uvm
    # Misc
    --bind=/dev/shm
    # Convenience
    --bind=$HOME/Public
    --bind=$HOME/Pictures
)

envs=(
    --setenv=DISPLAY="$DISPLAY"
    --setenv=PULSE_SERVER=unix:/run/user/$UID/pulse/native
)

### DBus

if [[ -n $DBUS_SESSION_BUS_ADDRESS ]]; then # remove prefix
    host_bus=${DBUS_SESSION_BUS_ADDRESS#unix:path=};
else # default guess
    host_bus=/run/user/$UID/bus;
fi

container_bus=/run/user/host/bus

envs+=("--setenv=DBUS_SESSION_BUS_ADDRESS=unix:path=$container_bus")
binds+=(--bind-ro="$host_bus:$container_bus")

### Wayland

WAYLAND_SOCK_PATH="/run/user/$UID/wayland-0"

if [[ -S "$WAYLAND_SOCK_PATH" ]]; then
    binds+=("--bind=$WAYLAND_SOCK_PATH")
fi

sudo systemd-nspawn $BOOT_FLAGS -D /var/lib/machines/tencent --user=$USER --chdir=$HOME \
    --settings=off "${binds[@]}" "${envs[@]}"
