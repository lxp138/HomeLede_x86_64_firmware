#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
#sed -i '$a src-git lienol https://github.com/Lienol/openwrt-package' feeds.conf.default


git clone https://github.com/godros/luci-app-godproxy.git ./package/lean/luci-app-godproxy
git clone https://github.com/jerrykuku/luci-app-jd-dailybonus.git ./package/lean/luci-app-jd-dailybonus
git clone https://github.com/ITdesk01/jd_openwrt_script.git ./package/lean/jd_openwrt_script
git clone https://github.com/jerrykuku/luci-app-ttnode.git ./package/lean/luci-app-ttnode
git clone https://github.com/xiaoqingfengATGH/lantern.git ./package/lean/lantern
# Add HomeLede prepareCompile.sh
disablePkgsList="
./feeds/pw/chinadns-ng 
./feeds/pw/ipt2socks 
./feeds/lienol/luci-app-softethervpn 
./package/lean/luci-app-kodexplorer 
./package/lean/luci-lib-docker 
./package/lean/luci-app-dockerman 
./package/lean/kcptun 
./package/lean/luci-theme-argon 
./package/lean/v2ray 
./package/lean/v2ray-plugin 
./package/lean/xray 
./package/lean/luci-app-jd-dailybonus 
./package/lean/luci-app-docker 
./package/lean/softethervpn5 
./package/lean/luci-app-softethervpn 
./feeds/packages/utils/docker-compose 
./feeds/packages/net/miniupnpd 
./feeds/packages/net/mwan3 
./feeds/packages/utils/docker-ce 
./feeds/packages/utils/containerd 
./feeds/packages/utils/libnetwork 
./feeds/packages/utils/tini 
./feeds/packages/utils/runc 
./feeds/packages/net/dnscrypt-proxy2 
./feeds/packages/net/https-dns-proxy 
./feeds/packages/net/kcptun 
./feeds/packages/net/smartdns 
./feeds/packages/net/xtables-addons 
./feeds/packages/net/softethervpn5 
./feeds/luci/applications/luci-app-sqm
"

function disableDulicatedPkg()
{
	if [ -d $1 ];then
		rm -rf $1
		echo $1" Disabled."
	fi
}

./scripts/feeds update -a

for disablePkg in $disablePkgsList
do
	disableDulicatedPkg $disablePkg
done

./scripts/feeds update -i
./scripts/feeds install -a

if [ ! -f .config ];then
cp defconfig .config
echo "Default .config created."
fi
