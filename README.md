# Expor API do K3s

1. Instalar o Nginx diretamente no servidor
2. Criar arquivo abaixo no diretório `/etc/nginx/sites-enabled`
3. Reiniciar o serviço do Nginx

```conf
server {
    listen 7443 ssl;
    server_name cluster.bonfimalan.com.br;

    # Your Let’s Encrypt certificate
    ssl_certificate     /etc/letsencrypt/live/cluster-cert/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/cluster-cert/privkey.pem;

    # Security for API server (optional)
    ssl_protocols TLSv1.2 TLSv1.3;

    location / {
        proxy_pass https://127.0.0.1:6443;
        proxy_ssl_verify off; # Important! The internal API uses self-signed cert
        proxy_ssl_server_name on;

        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-Proto https;
        proxy_set_header X-Forwarded-For $remote_addr;
    }
}
```
