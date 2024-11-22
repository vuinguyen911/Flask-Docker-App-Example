mkdir ssl
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout ssl/server.key -out ssl/server.crt

# Build the Docker image
docker build -t my-nginx .

# Run the container
docker run -d -p 80:80 -p 443:443 --name my-nginx-container my-nginx
