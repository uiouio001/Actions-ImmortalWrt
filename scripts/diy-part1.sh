#!/bin/bash
#===============================================
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#===============================================

#==============添加feed源地址===================
#Argon Theme
#sed -i '1i src-git argon https://github.com/jerrykuku/luci-theme-argon.git;master' feeds.conf.default
#sed -i '1i src-git argon-config https://github.com/jerrykuku/luci-app-argon-config.git;master' feeds.conf.default
git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
git clone https://github.com/jerrykuku/luci-app-argon-config.git package/luci-app-argon-config
#灵缇游戏加速器
git clone https://github.com/esirplayground/LingTiGameAcc.git lingtigameacc
git clone https://github.com/esirplayground/luci-app-LingTiGameAcc.git package/luci-app-LingTiGameAcc
