#!/bin/bash
#===============================================
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#===============================================

# 添加feed源地址
# 常用源
sed -i '1i src-git kenzo https://github.com/kenzok8/openwrt-packages;master' feeds.conf.default
#Argon Theme
sed -i '1i src-git argon https://github.com/jerrykuku/luci-theme-argon.git;master' feeds.conf.default
#OpenClash
sed -i '1i src-git openclash https://github.com/vernesong/OpenClash.git;master' feeds.conf.default

