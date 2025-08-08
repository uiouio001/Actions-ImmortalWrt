#!/bin/bash
#===============================================
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#===============================================


# 修改默认登录IP
#sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate

# 修改默认主题
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile
sed -i 's/config internal themes/config internal themes\n    option Argon  \"\/luci-static\/argon\"/g' feeds/luci/modules/luci-base/root/etc/config/luci

echo '去除默认bootstrap主题'
sed -i '/set luci.main.mediaurlbase=\/luci-static\/bootstrap/d' feeds/luci/themes/luci-theme-bootstrap/root/etc/uci-defaults/30_luci-theme-bootstrap

# 修改默认主机名
sed -i 's/OpenWrt/ImmortalWrt/g' package/base-files/files/bin/config_generate


# 删除软件包
#rm -rf feeds/luci/themes/luci-theme-bootstrap
#rm -rf feeds/luci/applications/luci-app-zerotier
#rm -rf feeds/luci/applications/luci-app-socat
#rm -rf feeds/packages/net/v2ray-geodata
#rm -rf feeds/packages/net/open-app-filter


# 添加额外软件包
#git clone -b master --single-branch https://github.com/vernesong/OpenClash package/luci-app-openclash
#git clone https://github.com/sirpdboy/luci-app-ddns-go package/luci-app-ddns-go
#git clone https://github.com/sirpdboy/luci-app-lucky package/luci-app-lucky


# 删除DDNS's示例
sed -i '/myddns_ipv4/,$d' feeds/packages/net/ddns-scripts/files/etc/config/ddns

# Manually set CPU frequency for MT7981B
sed -i '/"mediatek"\/\*|\"mvebu"\/\*/{n; s/.*/\tcpu_freq="1.3GHz" ;;/}' package/emortal/autocore/files/generic/cpuinfo


