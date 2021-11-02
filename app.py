from flask import Flask, render_template
from flask_bootstrap import Bootstrap
import netifaces as ni
import socket

app = Flask(__name__)
Bootstrap(app)

def get_ipaddress():
    ip = None
    for interface in ni.interfaces():
        if interface == 'lo':
            continue
        data = ni.ifaddresses(interface)
        if 2 in data:
            ip = data[2][0]['addr']
    return ip

@app.route('/')
@app.route('/index')
def index():
    hostname = socket.gethostname()
    ip = get_ipaddress()
    return render_template('dash.html', hostname=hostname, ip=ip)


if __name__ == '__main__':
    app.run(host='0.0.0.0',port=8080)
