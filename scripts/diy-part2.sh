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

# 修改默认主机名
sed -i 's/OpenWrt/ImmortalWrt/g' package/base-files/files/bin/config_generate

# 删除软件包
#rm -rf feeds/luci/themes/luci-theme-bootstrap
#rm -rf feeds/luci/applications/luci-app-zerotier

# 添加额外软件包
#git clone https://github.com/sirpdboy/luci-app-lucky package/luci-app-lucky

# 删除DDNS's示例
sed -i '/myddns_ipv4/,$d' feeds/packages/net/ddns-scripts/files/etc/config/ddns

# 重新设置CPU主频 for MT7981B
sed -i '/"mediatek"\/\*|\"mvebu"\/\*/{n; s/.*/\tcpu_freq="1.3GHz" ;;/}' package/emortal/autocore/files/generic/cpuinfo


