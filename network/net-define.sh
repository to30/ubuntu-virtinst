#!/bin/bash

virsh net-define openstack.xml
virsh net-start openstack
virsh net-autostart openstack

virsh net-list --all
