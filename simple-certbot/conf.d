server {
    listen 80;
    server_name test.facevox.jp;

    location / {
        proxy_pass http://flask_app:5000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    location /.well-known/acme-challenge/ {
        root /var/www/certbot;
    }

    # Redirect tất cả các yêu cầu HTTP sang HTTPS
    if ($scheme != "https") {
        return 301 https://$host$request_uri;
    }
}

server {
    listen 443 ssl;
    server_name test.facevox.jp;

    ssl_certificate /etc/letsencrypt/live/test.facevox.jp/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/test.facevox.jp/privkey.pem;

    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_prefer_server_ciphers on;
    ssl_ciphers "ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256";

    location / {
        proxy_pass http://flask_app:5000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
