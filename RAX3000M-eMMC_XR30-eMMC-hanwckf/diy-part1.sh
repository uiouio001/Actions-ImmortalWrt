#!/bin/bash
#===============================================
# Description: DIY script
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
# Author: uiouio
# Github: https://github.com/uiouio
#===============================================

# 修改版本为编译日期，数字类型。
date_version=$(date +"%Y%m%d%H")
echo $date_version > version

# 为iStoreOS固件版本加上编译作者
author="Uiouio"
sed -i "s/DISTRIB_DESCRIPTION.*/DISTRIB_DESCRIPTION='%D %V ${date_version} by ${author}'/g" package/base-files/files/etc/openwrt_release
sed -i "s/OPENWRT_RELEASE.*/OPENWRT_RELEASE=\"%D %V ${date_version} by ${author}\"/g" package/base-files/files/usr/lib/os-release

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
#echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default

# 拉取我的软件包仓库
sed -i '$a src-git xmpackage https://github.com/xiaomeng9597/openwrt-packages2.git;main' feeds.conf.default
#git clone https://github.com/messense/aliyundrive-webdav package/messense
git clone https://github.com/destan19/OpenAppFilter package/OpenAppFilter
