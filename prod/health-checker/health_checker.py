from http.server import BaseHTTPRequestHandler, HTTPServer
import requests
import json

SERVICES = {
    "grafana": "http://grafana:3000/api/health",
    "prometheus": "http://prometheus:9090/-/ready",
    "loki": "http://loki:3100/ready",
    "alertmanager": "http://alertmanager:9093/-/ready",
}

class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        if self.path != "/health":
            self.send_response(404)
            self.end_headers()
            return

        results = {}
        failed = []

        for name, url in SERVICES.items():
            try:
                r = requests.get(url, timeout=2)
                if r.status_code == 200:
                    results[name] = "UP"
                else:
                    results[name] = "DOWN"
                    failed.append(name)
            except Exception:
                results[name] = "DOWN"
                failed.append(name)


        if failed:
            self.send_response(503)
            status = "DOWN"
        else:
            self.send_response(200)
            status = "UP"

        self.send_header("Content-Type", "application/json")
        self.end_headers()

        response = {
            "status": status,
            "components": results
        }

        self.wfile.write(json.dumps(response).encode("utf-8"))


HTTPServer(("0.0.0.0", 8080), Handler).serve_forever()