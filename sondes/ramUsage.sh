#!/bin/bash

ram_usage=$(free | awk '/Mem/ {printf("%.2f", $3/$2 * 100)}')
echo "$ram_usage"
