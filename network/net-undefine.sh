#!/bin/bash -x

virsh net-destroy openstack
virsh net-undefine openstack

virsh net-list --all
