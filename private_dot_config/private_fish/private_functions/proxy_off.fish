function proxy_off
    set -eU http_proxy
    set -eU https_proxy
    set -eU all_proxy

    echo "Proxy disabled"
end
