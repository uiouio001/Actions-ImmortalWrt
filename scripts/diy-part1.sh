#!/bin/bash
#===============================================
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#===============================================


# 修改版本为编译日期，数字类型。
date_version=$(date +"%Y%m%d%H")
echo $date_version > version

# 为固件版本加上编译作者
author="OpenWrt"
sed -i "s/DISTRIB_DESCRIPTION.*/DISTRIB_DESCRIPTION='%D %V ${date_version} by ${author}'/g" package/base-files/files/etc/openwrt_release
sed -i "s/OPENWRT_RELEASE.*/OPENWRT_RELEASE=\"%D %V ${date_version} by ${author}\"/g" package/base-files/files/usr/lib/os-release


# 添加feed源地址
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default



