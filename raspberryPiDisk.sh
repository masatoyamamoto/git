#!/bin/bash
diskutil info /dev/rdisk1
diskutil unmount /dev/disk1s1
sudo dd if=~/Documents/computer/raspberry\ pi/2012-12-16-wheezy-raspbian.img of=/dev/rdisk1 bs=1m
diskutil unmount /dev/disk1s1
