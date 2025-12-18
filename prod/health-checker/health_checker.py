from http.server import BaseHTTPRequestHandler, HTTPServer
import requests

SERVICES = [
    "http://grafana:3000/api/health",        # grafana
    "http://prometheus:9090/-/ready",        # prometheus
    "http://loki:3100/ready",                # loki
    "http://alertmanager:9093/-/ready",      # alertmanager
]

class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        if self.path != "/health":
            self.send_response(404)
            self.end_headers()
            return

        try:
            for url in SERVICES:
                r = requests.get(url, timeout=2)
                if r.status_code != 200:
                    raise Exception(url)

            self.send_response(200)
            self.end_headers()
            self.wfile.write(b"OK")

        except Exception:
            self.send_response(503)
            self.end_headers()
            self.wfile.write(b"DOWN")


HTTPServer(("0.0.0.0", 8080), Handler).serve_forever()