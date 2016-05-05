#!/bin/bash -x

NODES="stack01 stack02 stack03 stackwork"

export LANG=C

for vm in $NODES; do
    if virsh list --all | grep -q -E "^${vm}$"; then
        if `virsh domstate $vm | head -1` != 'shut off'; then
            virsh destroy $vm
            sleep 2
        fi
        virsh undefine $vm
    fi
done

# Delete image files
for vm in $NODES; do
    sudo rm -f /var/lib/libvirt/images/${vm}.img
done
for vm in stack02 stack03; do
    sudo rm -f /var/lib/libvirt/images/${vm}-volumes.img
done

# Delete SSH host keys
for addr in 10 11 12 13; do
    ssh-keygen -R 192.168.100.$addr
done
