#!/bin/bash
#===============================================
# Description: DIY script
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
# Author: uiouio
# Github: https://github.com/uiouio
#===============================================

# 修改默认登录IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate

# 修改默认主题
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# 修改默认主机名
sed -i 's/OpenWrt/CYRouter/g' package/base-files/files/bin/config_generate

##-----------------Del duplicate packages------------------
rm -rf feeds/packages/net/open-app-filter

##-----------------Add OpenClash dev core------------------
curl -sL -m 30 --retry 2 https://raw.githubusercontent.com/vernesong/OpenClash/core/master/dev/clash-linux-arm64.tar.gz -o /tmp/clash.tar.gz
tar zxvf /tmp/clash.tar.gz -C /tmp >/dev/null 2>&1
chmod +x /tmp/clash >/dev/null 2>&1
mkdir -p feeds/luci/applications/luci-app-openclash/root/etc/openclash/core
mv /tmp/clash feeds/luci/applications/luci-app-openclash/root/etc/openclash/core/clash >/dev/null 2>&1
rm -rf /tmp/clash.tar.gz >/dev/null 2>&1

##-----------------Delete DDNS's examples-----------------
sed -i '/myddns_ipv4/,$d' feeds/packages/net/ddns-scripts/files/etc/config/ddns

##-----------------Manually set CPU frequency for MT7981B-----------------
sed -i '/"mediatek"\/\*|\"mvebu"\/\*/{n; s/.*/\tcpu_freq="1.3GHz" ;;/}' package/emortal/autocore/files/generic/cpuinfo


