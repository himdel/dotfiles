# nvidia notes

orome only. It has a GeForce RTX 3070 (GA104), while lorien is intel graphics and
`dependencies` carries lorien's intel set (`firmware-intel-*`, `intel-media-va-driver`,
`intel-opencl-icd`, `xserver-xorg-video-intel`). So the nvidia packages are not in
`dependencies`, and nothing in `bin/` assumes a GPU.

## Packages

    sudo apt install nvidia-driver nvidia-settings nvidia-smi nvidia-detect \
      firmware-nvidia-graphics firmware-nvidia-gsp

`nvidia-detect` names the driver branch the card wants.

For CUDA:

    sudo apt install nvidia-cuda-toolkit nvidia-cuda-dev nvidia-cuda-mps

i386, for steam (`install` already does `dpkg --add-architecture i386`):

    sudo apt install nvidia-driver-libs:i386 nvidia-vulkan-icd:i386

orome is on driver 550.163.01 with CUDA 12.4, as of 2026-09. To check:

    cat /proc/driver/nvidia/version
    nvidia-smi

## nvidia_uvm does not survive suspend

The compute module comes back wedged after a resume, so CUDA fails until it is reloaded.
Anything touching CUDA needs the module cycled first:

    sudo modprobe -r nvidia_uvm
    sudo modprobe nvidia_uvm

orome appends that to its local `bin/s2ram`:

    #!/bin/sh
    echo mem > /sys/power/state
    modprobe -r nvidia_uvm
    modprobe nvidia_uvm

No sudo in that one, `bin/susp` already calls s2ram through sudo. Kept out of the
tracked `bin/s2ram` because `modprobe -r` fails noisily on a box with no nvidia module
loaded.

Four modules should be up afterwards: `nvidia`, `nvidia_uvm`, `nvidia_modeset`,
`nvidia_drm`. `lsmod | grep nvidia` confirms it.

## easy-diffusion

Same reload, then the upstream launcher. orome's `bin/sd`, untracked because
`~/easy-diffusion` is orome-only:

    #!/bin/bash

    sudo modprobe -r nvidia_uvm
    sudo modprobe nvidia_uvm

    cd ~/easy-diffusion
    ./start.sh
