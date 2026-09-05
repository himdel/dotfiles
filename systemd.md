# systemd notes

(Nothing in `dependencies`, `bin/` or `etc/` assumes either init)

## Packages

Already there after a default install: `systemd`, `systemd-sysv`, `libpam-systemd`.

Coming back from sysvinit:

    sudo apt install systemd-sysv
    sudo apt purge sysvinit-core orphan-sysvinit-scripts bootlogd \
      elogind libpam-elogind systemd-standalone-tmpfiles

The switch to sysvinit leaves a pile of `/etc/systemd/system/*.service -> /dev/null`
masks, one per sysvinit-era init script. Clear them out on the way back, or the
generator has nothing to fall back on:

    find /etc/systemd/system -maxdepth 1 -lname /dev/null

## Lid switch

    # /etc/systemd/logind.conf
    [Login]
    HandleLidSwitch=ignore

Same key under elogind, see `sysvinit.md`.

## Keep my processes alive after logout

both:

    # /etc/systemd/logind.conf
    [Login]
    KillUserProcesses=no

    sudo loginctl enable-linger himdel

`KillUserProcesses=no` stops the session scope teardown from taking tmux and long jobs
with it. `enable-linger` keeps the user manager (and anything under it) running when no
session is open at all, which is what lets a user unit start at boot and what keeps a
detached tmux around between logins.

## Limits

defaults too low, raise:

    # /etc/systemd/system.conf
    [Manager]
    DefaultLimitNOFILE=1048576:1048576
    DefaultLimitNPROC=61440

## Journal

Unbounded by default, cap:

    # /etc/systemd/journald.conf
    [Journal]
    SystemMaxUse=512M
    SystemMaxFileSize=64M

## Services to turn off

    sudo systemctl disable wpa_supplicant

`etc/network/interfaces` brings wlan0 up with `wpa-conf`, so the standalone
wpa\_supplicant unit just fights it for the interface.

Check for the usual duplicates before trusting the network config:

    systemctl list-unit-files --state=enabled

NetworkManager and ifupdown both managing the same interface is the common one - disable the other one

DNS and DHCP config itself is the same under both inits.

## rc.local

Not run at all. Debian's systemd ships no `rc-local.service` to enable, so write the
whole thing:

    # /etc/systemd/system/rc-local.service
    [Unit]
    Description=/etc/rc.local
    ConditionFileIsExecutable=/etc/rc.local
    After=network-online.target
    Wants=network-online.target

    [Service]
    Type=oneshot
    RemainAfterExit=yes
    ExecStart=/etc/rc.local

    [Install]
    WantedBy=multi-user.target

then

    sudo systemctl enable --now rc-local

`ConditionFileIsExecutable` means it quietly does nothing if `/etc/rc.local` ever loses
+x, which is the usual way this breaks.

## sysctl and modules

Nothing to do. systemd-sysctl reads `/etc/sysctl.conf` and `/etc/sysctl.d/`, and
systemd-modules-load reads `/etc/modules` through `/etc/modules-load.d/modules.conf`,
a symlink `udev` ships. Both files stay tracked in `etc/` and work under either init.
