#!/bin/bash
#===============================================
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#===============================================

#==============添加feed源地址===================
# 常用APP源
#sed -i '1i src-git kenzo https://github.com/kenzok8/openwrt-packages.git;master' feeds.conf.default
# iStoreOS
#sed -i '1i src-git istore https://github.com/linkease/istore.git;main' feeds.conf.default
#sed -i '1i src-git third_party https://github.com/linkease/istore-packages.git;main' feeds.conf.default
#sed -i '1i src-git linkease_nas_luci https://github.com/linkease/nas-packages-luci.git;main' feeds.conf.default
#Argon Theme
#sed -i '1i src-git argon https://github.com/jerrykuku/luci-theme-argon.git;master' feeds.conf.default
#OpenClash
#sed -i '1i src-git openclash https://github.com/vernesong/OpenClash.git;master' feeds.conf.default

