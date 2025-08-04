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


# update ubus git HEAD
cp -f $GITHUB_WORKSPACE/configfiles/ubus_Makefile package/system/ubus/Makefile

# 近期istoreos网站文件服务器不稳定，临时增加一个自定义下载网址
sed -i "s/push @mirrors, 'https:\/\/mirror2.openwrt.org\/sources';/&\\npush @mirrors, 'https:\/\/github.com\/xiaomeng9597\/files\/releases\/download\/iStoreosFile';/g" scripts/download.pl

# 移植黑豹x2（这些配置文件上游仓库已经有了不用在复制了）
# 上游仓库地址：https://github.com/istoreos/istoreos

# rm -f target/linux/rockchip/image/rk35xx.mk
# cp -f $GITHUB_WORKSPACE/configfiles/rk35xx.mk target/linux/rockchip/image/rk35xx.mk

# rm -f target/linux/rockchip/rk35xx/base-files/lib/board/init.sh
# cp -f $GITHUB_WORKSPACE/configfiles/init.sh target/linux/rockchip/rk35xx/base-files/lib/board/init.sh

# rm -f target/linux/rockchip/rk35xx/base-files/etc/board.d/02_network
# cp -f $GITHUB_WORKSPACE/configfiles/02_network target/linux/rockchip/rk35xx/base-files/etc/board.d/02_network


# 修改内核配置文件
# rm -f target/linux/rockchip/rk35xx/config-5.10
# cp -f $GITHUB_WORKSPACE/configfiles/config-5.10 target/linux/rockchip/rk35xx/config-5.10
sed -i "/.*CONFIG_ROCKCHIP_RGA2.*/d" target/linux/rockchip/rk35xx/config-5.10
# sed -i "/# CONFIG_ROCKCHIP_RGA2 is not set/d" target/linux/rockchip/rk35xx/config-5.10
# sed -i "/CONFIG_ROCKCHIP_RGA2_DEBUGGER=y/d" target/linux/rockchip/rk35xx/config-5.10
# sed -i "/CONFIG_ROCKCHIP_RGA2_DEBUG_FS=y/d" target/linux/rockchip/rk35xx/config-5.10
# sed -i "/CONFIG_ROCKCHIP_RGA2_PROC_FS=y/d" target/linux/rockchip/rk35xx/config-5.10

# 替换dts文件
cp -f $GITHUB_WORKSPACE/configfiles/rk3566-jp-tvbox.dts target/linux/rockchip/dts/rk3568/rk3566-jp-tvbox.dts
cp -f $GITHUB_WORKSPACE/configfiles/rk3566-panther-x2.dts target/linux/rockchip/dts/rk3568/rk3566-panther-x2.dts

#修改uhttpd配置文件，启用nginx
# sed -i "/.*uhttpd.*/d" .config
# sed -i '/.*\/etc\/init.d.*/d' package/network/services/uhttpd/Makefile
# sed -i '/.*.\/files\/uhttpd.init.*/d' package/network/services/uhttpd/Makefile
sed -i "s/:80/:81/g" package/network/services/uhttpd/files/uhttpd.config
sed -i "s/:443/:4443/g" package/network/services/uhttpd/files/uhttpd.config
cp -a $GITHUB_WORKSPACE/configfiles/etc/* package/base-files/files/etc/
# ls package/base-files/files/etc/


# 增加ido3568 DG NAS LITE
echo -e "\\ndefine Device/dg_nas
\$(call Device/rk3568)
  DEVICE_VENDOR := DG
  DEVICE_MODEL := NAS LITE
  DEVICE_DTS := rk3568-firefly-roc-pc-se
  SUPPORTED_DEVICES += dg,nas
  DEVICE_PACKAGES := kmod-nvme kmod-scsi-core
endef
TARGET_DEVICES += dg_nas" >> target/linux/rockchip/image/rk35xx.mk

sed -i "s/panther,x2|\\\/&\\n	dg,nas|\\\/g" target/linux/rockchip/rk35xx/base-files/lib/board/init.sh

sed -i "s/panther,x2|\\\/&\\n	dg,nas|\\\/g" target/linux/rockchip/rk35xx/base-files/etc/board.d/02_network

# 增加nsy-g68-plus
echo -e "\\ndefine Device/nsy-g68plus
\$(call Device/rk3568)
  DEVICE_VENDOR := NSY
  DEVICE_MODEL := G68PLUS
  DEVICE_DTS := nsy-g68plus
  SUPPORTED_DEVICES += nsy,g68-plus
  DEVICE_PACKAGES := kmod-nvme kmod-scsi-core kmod-thermal kmod-switch-rtl8306 kmod-switch-rtl8366-smi kmod-switch-rtl8366rb 
  kmod-switch-rtl8366s kmod-hwmon-pwmfan kmod-leds-pwm kmod-r8125 kmod-r8168 kmod-switch-rtl8367b swconfig
endef
TARGET_DEVICES += nsy-g68plus" >> target/linux/rockchip/image/rk35xx.mk

#增加RK3566-HJQ
echo -e "\\ndefine Device/rk3566_hjq
\$(call Device/rk3566)
  DEVICE_VENDOR := Rockchip
  DEVICE_MODEL := RK3566 EVB2 LP4X V10 Board
  DEVICE_DTS := rk3566-odroid-m1s
  SUPPORTED_DEVICES += rk3566,hjq
  DEVICE_PACKAGES := kmod-scsi-core kmod-rtl8723ds kmod-hwmon-pwmfan kmod-thermal kmod-switch-rtl8367b swconfig
endef
TARGET_DEVICES += rk3566_hjq" >> target/linux/rockchip/image/rk35xx.mk

cp -f $GITHUB_WORKSPACE/configfiles/rk3568-firefly-roc-pc-se-core.dtsi target/linux/rockchip/dts/rk3568/rk3568-firefly-roc-pc-se-core.dtsi
cp -f $GITHUB_WORKSPACE/configfiles/rk3568-firefly-roc-pc-se.dts target/linux/rockchip/dts/rk3568/rk3568-firefly-roc-pc-se.dts
cp -f $GITHUB_WORKSPACE/configfiles/rk3568-dg-nas.dts target/linux/rockchip/dts/rk3568/rk3568-dg-nas.dts
cp -f $GITHUB_WORKSPACE/configfiles/nsy-g68plus.dts target/linux/rockchip/dts/rk3568/nsy-g68plus.dts
cp -f $GITHUB_WORKSPACE/configfiles/nsy-g68plus-core.dtsi target/linux/rockchip/dts/rk3568/nsy-g68plus-core.dtsi
cp -f $GITHUB_WORKSPACE/configfiles/rk3566-odroid-m1s.dts target/linux/rockchip/dts/rk3568/rk3566-odroid-m1s.dts-roc-pc-se.dts

#轮询检查ubus服务是否崩溃，崩溃就重启ubus服务
cp -f $GITHUB_WORKSPACE/configfiles/httpubus package/base-files/files/etc/init.d/httpubus
cp -f $GITHUB_WORKSPACE/configfiles/ubus-examine.sh package/base-files/files/bin/ubus-examine.sh
chmod 755 package/base-files/files/etc/init.d/httpubus
chmod 755 package/base-files/files/bin/ubus-examine.sh


#集成黑豹X2和荐片TV盒子无线功能并且开启无线功能
cp -a $GITHUB_WORKSPACE/configfiles/firmware/* package/firmware/
cp -f $GITHUB_WORKSPACE/configfiles/opwifi package/base-files/files/etc/init.d/opwifi
chmod 755 package/base-files/files/etc/init.d/opwifi
sed -i "s/wireless.radio\${devidx}.disabled=1/wireless.radio\${devidx}.disabled=0/g" package/kernel/mac80211/files/lib/wifi/mac80211.sh

#集成CPU性能跑分脚本
cp -a $GITHUB_WORKSPACE/configfiles/coremark/* package/base-files/files/bin/
chmod 755 package/base-files/files/bin/coremark
chmod 755 package/base-files/files/bin/coremark.sh

