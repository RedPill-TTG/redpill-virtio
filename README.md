# VirtIO for RedPill

This repository contains a packaged version of the [VirtIO driver set](https://www.linux-kvm.org/page/Virtio) in a form
of an extension for RedPill-powered systems. To learn more about RedPill extensions see [`redpill-load`](https://github.com/RedPill-TTG/redpill-load).

## Purpose
This extension adds support for fast para-virtualized devices in hypervisors supporting VirtIO. The following features 
are supported:

 - MMIO-mapped devices
 - PCI(e) passthrough devices
 - Ethernet devices
 - SCSI/SATA storage

Unsupported features (as of now):
 - Memory ballooning
 - 9pfs
 

The following hypervisors are known to support VirtIO:
 - Proxmox
 - virsh
 - unRAID
 - VirtualBox


## Installation
This module comes preinstalled/bundled with `redpill-load`. If you're a developer, and you're creating a custom fork you
should use index URL of `https://raw.githubusercontent.com/RedPill-TTG/redpill-virtio/master/rpext-index.json`


## Usage
The extension automatically determines if the system is suitable to load VirtIO drivers. No manual actions are necessary
from the user. The easiest way to check if it's working properly is the use a `virtio` ethernet card.


## Known issues
 - There's no instruction how to build VirtIO and obtain these files here
 - 9pfs is not included in this build


## Developer's note on creating packages
To ensure minimal diffs and stable archives the following method should be used to create tgz packages present in this
repository:

```shell
# Run in a directory containing directories with virtio drivers inside them like so:
# .  => run here
# ├── check-virtio.sh
# ├── virtio-3.10.105
# │   ├── virtio_balloon.ko
# │   ├── virtio_blk.ko
# │   ├── virtio_console.ko
# │   ├── virtio.ko
# │   ├── virtio_mmio.ko
# │   ├── virtio_net.ko
# │   ├── virtio_pci.ko
# │   ├── virtio_ring.ko
# │   └── virtio_scsi.ko
# ........

for dir in $(ls -A -1 -d */ | sed 's^/^^'); do
    tar \
      --mtime="1970/01/01 00:00:00" \
      --owner=0 --group=0 --numeric-owner \
      --pax-option=exthdr.name=%d/PaxHeaders/%f,delete=atime,delete=ctime \
      -cf - "${dir}" | gzip -n > "${dir}.tgz"
done
```
