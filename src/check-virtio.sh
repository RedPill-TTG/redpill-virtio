echo "Checking for VirtIO"
if (grep -r -q -E "(QEMU|VirtualBox)" /sys/devices/virtual/dmi/id/); then
  echo "VirtIO hypervisor detected"
  exit 0
else
  echo "*No* VirtIO hypervisor detected"
  exit 1
fi
