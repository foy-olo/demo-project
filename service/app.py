"""
A sample Hello World server.
"""
import os

from flask import Flask, render_template

app = Flask(__name__)


@app.route('/')
def hello():
    """Return a friendly HTTP greeting."""
    message = "Hello World!"

if __name__ == '__main__':
    server_port = os.environ.get('PORT', 8080)
    app.run(debug=False, port=server_port, host='0.0.0.0')
