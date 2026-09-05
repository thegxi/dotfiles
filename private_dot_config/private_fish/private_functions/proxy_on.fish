function proxy_on
    set -Ux http_proxy http://127.0.0.1:7890
    set -Ux https_proxy http://127.0.0.1:7890
    set -Ux all_proxy socks5://127.0.0.1:7890

    echo "Proxy enabled"
    echo "HTTP : $http_proxy"
    echo "HTTPS: $https_proxy"
    echo "SOCKS: $all_proxy"
end
