1. build
docker build -t my-html-website .

2. run
    c1: docker run -d -p 80:80 --name my-running-html-website my-html-website
    c2: docker-compose up -d
