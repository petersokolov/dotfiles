# Toshiba Sattelite R830-13D - Arch Linux Lab

## Overview
This machine is a minimal Arch Linux environment. It is configured to run in "Clamshell Mode" (lid closed) as a headless server, accessible via SSH, while maintaining a functional `i3wm` local desktop.

---

## Snapshot Management (Btrfs)
The system uses Btrfs "Copy-on-Write" snapshots. These are block-level, meaning they are instant and only consume space as files are changed.

### Key Commands
* **Create Snapshot:** `sudo btrfs subvolume snapshot / /.snapshots/YYYY-MM-DD_description`
* **List Snapshots:** `ls /.snapshots`
* **Check Real Disk Usage:** `sudo btrfs filesystem du -s /`

### Rollback Procedure
If the system becomes unbootable:
1. Boot from an Arch ISO USB.
2. Mount the root partition: `mount /dev/sda2 /mnt`
3. Rename the broken subvolume: `mv /mnt/@ /mnt/@_broken`
4. Restore from snapshot: `btrfs subvolume snapshot /mnt/.snapshots/toshiba-gold-master /mnt/@`
5. Reboot.


---

## Hardware & GUI Configuration

### Volume & Media Keys
Mapped in `~/.config/i3/config` using `bindcode` (X11 code = Kernel code + 8).
* **Volume Up (Fn + 3):** `bindcode 123` -> `amixer -q -c 0 sset Master 5%+ unmute`
* **Volume Down (Fn + 4):** `bindcode 122` -> `amixer -q -c 0 sset Master 5%- unmute`
* **Mute:** `bindcode 121` -> `amixer sset Master toggle`

### Power & Lid Behavior
Configured in `/etc/systemd/logind.conf`:
* **HandleLidSwitch=ignore**: Prevents suspend when the lid is closed.
* **Screen Power:** Use `$mod+Shift+b` (`xset dpms force off`) to kill the backlight manually.

### Touchpad
Tapping is enabled via Libinput in `/etc/X11/xorg.conf.d/40-libinput.conf`.

---

## Systems Setup
* **Microcode:** `intel-ucode` is loaded first in GRUB to patch the i5 CPU.
* **Time:** `systemd-timesyncd` is active to prevent SSL errors from CMOS battery drift.
* **Power:** `tlp` is enabled for battery management.


---

## (TODO) Dotfile Strategy (GNU Stow)
The `dotfiles` repo is organized by "Package" to support Mac, RPi, and Arch:
1. `common/`: Shared `.vimrc`, `.zshrc`.
2. `toshiba-arch/`: i3 configs, X11 snippets, logind settings.
3. `macos/`: Brew and Zsh overrides.

---

### Maintenance Notes
* **Current Gold Master:** `/.snapshots/toshiba-gold-master`
* **Current Gold Master Server (not hybernating with lid closed):** `/.snapshots/toshiba-gold-master-server`
* **Audio Card:** Internal Intel HDA is Card `0`.
* **Thermal Tip:** Keep lid slightly ajar during high CPU loads to vent heat.
