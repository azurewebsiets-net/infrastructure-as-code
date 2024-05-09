resource "kubernetes_config_map" "nginx_conf" {
  metadata {
    name      = "nginx-conf"
    namespace = kubernetes_namespace.main.metadata.0.name
  }

  data = {
    "nginx.conf" = <<EOF
http {
    log_format main_with_host '$remote_addr - $remote_user [$time_local] "$request" '
                              '$status $body_bytes_sent "$http_referer" "$http_user_agent" '
                              'host: "$host"';
    access_log /var/log/nginx/access.log main_with_host;

    include /etc/nginx/conf.d/*.conf;
}

events {}

error_log  /var/log/nginx/error.log warn;
EOF
  }
}
