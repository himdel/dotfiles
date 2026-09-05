# sysvinit notes

the rest of config should be init-agnostic

## Packages

    sudo apt install sysvinit-core sysvinit-utils orphan-sysvinit-scripts \
      elogind libpam-elogind systemd-standalone-tmpfiles bootlogd

Installing `sysvinit-core` pulls systemd's PID 1 out. Reboot after. To test before
committing to it, boot once with `init=/lib/sysvinit/init` on the kernel command line.

- `elogind` + `libpam-elogind` replace systemd-logind: seats, sessions, lid switch,
  and the polkit bits that let a normal user suspend and mount.
- `systemd-standalone-tmpfiles` gives you `systemd-tmpfiles` without PID 1, for the
  packages whose postinst expects it.
- `orphan-sysvinit-scripts` carries `/etc/init.d/` scripts for packages that dropped
  theirs and now only ship a unit file.

## Files

- `/etc/inittab` is stock, no local changes. Runlevel 2 default, getty on tty1-6.
- `/etc/modules` is read at boot by the kmod init script. Under systemd it is read
  through `/etc/modules-load.d/modules.conf`, a symlink shipped by `udev`, so the same
  file works either way and stays tracked in `etc/`.
- `/etc/rc.local` needs nothing. `initscripts` (auto, via `util-linux-extra`) ships
  `/etc/init.d/rc.local` and wires it into rc2-5.d at S07. Under systemd it is not run
  at all and takes a hand-written unit, see `systemd.md`.
- the `sysctl -p /etc/sysctl.conf` line in `rc.local` is only relevant with sysvinit,
  systemd-sysctl does that on its own.

## Lid switch

Same key as systemd's `/etc/systemd/logind.conf` (see `systemd.md`), different file:

    # /etc/elogind/logind.conf
    [Login]
    HandleLidSwitch=ignore

## Services

`service foo start|stop` and `update-rc.d` work regardless of init, and the scripts in
`bin/` use `service` for that reason. There is no `systemctl`.
