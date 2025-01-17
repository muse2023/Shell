#!/bin/bash

# 目标域名
target="www.gstatic.com"

# 临时文件存储ping结果
temp_file="/tmp/ping_results.txt"

# 执行ping命令并存储结果
ping -c 5 $target | grep 'bytes from' | awk -F' ' '{print $4 " " $7}' | sed 's/time=//g' > $temp_file

# 查找最小延迟的行
min_delay_line=$(sort -k2 -n $temp_file | head -n 1)

# 获取最低延迟的 IP 地址
min_ip=$(echo $min_delay_line | awk '{print $1}')

# 获取主机名
hostname=$(echo $target | awk -F'.' '{print $1}')

# 写入/etc/hosts
echo "$min_ip $hostname" | sudo tee -a /etc/hosts

# 删除临时文件
rm $temp_file

echo "IP地址 $min_ip 已经写入 /etc/hosts 作为 $hostname"
