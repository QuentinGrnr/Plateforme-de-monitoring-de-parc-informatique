#!/bin/bash

disk_usage=$(df -h | awk '$NF=="/" {print $5}' | sed 's/%//')
echo "$disk_usage"
