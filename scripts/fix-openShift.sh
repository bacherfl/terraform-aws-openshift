#!/usr/bin/env bash

sudo su

yum-config-manager --enable http://mirrors.oit.uci.edu/centos/7/paas/x86_64/openshift-origin311/
yum update -y
yum install -y skopeo

systemctl enable iptables.service && systemctl start iptables.service
