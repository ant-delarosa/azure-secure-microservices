from flask import Flask, jsonify, render_template, Response
import platform
import socket
import datetime
import psutil

app = Flask(__name__)

# HTML dashboard
@app.route("/")
def home():
    system_info = {
        "hostname": socket.gethostname(),
        "ip_address": socket.gethostbyname(socket.gethostname()),
        "os": platform.system() + " " + platform.release(),
        "python_version": platform.python_version(),
        "uptime": str(datetime.datetime.now() - datetime.datetime.fromtimestamp(psutil.boot_time())),
        "cpu_usage": psutil.cpu_percent(),
        "memory_usage": psutil.virtual_memory().percent
    }
    return render_template("dashboard.html", info=system_info)

# JSON API endpoint
@app.route("/api/status")
def api_status():
    return jsonify({
        "status": "ok",
        "timestamp": datetime.datetime.utcnow().isoformat() + "Z",
        "cpu_usage": psutil.cpu_percent(),
        "memory_usage": psutil.virtual_memory().percent
    })


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
