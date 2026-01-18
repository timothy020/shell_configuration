#!/bin/bash

if curl --socks5 192.168.31.1:7890 -s --connect-timeout 3 -s --max-time 0.5 http://www.gstatic.com/generate_204 >/dev/null; then
	export ALL_PROXY="socks5://192.168.31.1:7890"
	export HTTP_PROXY="http://192.168.31.1:7890"
	export HTTPS_PROXY="http://192.168.31.1:7890"
	echo "✅ 使用网关代理：192.168.31.1:7890"
else
	export ALL_PROXY="socks5://127.0.0.1:7890"
	export HTTP_PROXY="http://127.0.0.1:7890"
	export HTTPS_PROXY="http://127.0.0.1:7890"
	echo "⚠️ 网关不可用，使用本机代理：127.0.0.1:7890"
fi
