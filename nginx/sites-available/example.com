server {
    listen 443 ssl;
    listen [::]:443 ssl;
    include snippets/self-signed.conf;
    include snippets/ssl-params.conf;

    server_name example.com www.example.com;

    root /var/www/example.com/html;
    index index.html index.htm index.nginx-debian.html;

}

server {
    listen 80;
    listen [::]:80;

    server_name example.com www.example.com;

    return 302 https://$server_name$request_uri;
}
