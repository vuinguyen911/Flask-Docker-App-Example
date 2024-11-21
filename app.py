from flask import Flask

app = Flask(__name__)


@app.route('/')
def hello_geek():
    return '<h1>Hello from Flask, Certbot & Docker</h2>'


if __name__ == "__main__":
    app.run(debug=True, port=5000, host="0.0.0.0")
