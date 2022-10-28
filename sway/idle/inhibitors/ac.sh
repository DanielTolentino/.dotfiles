#!/bin/bash

grep 1 /sys/class/power_supply/ACAD/online && exit 1 || exit 0
