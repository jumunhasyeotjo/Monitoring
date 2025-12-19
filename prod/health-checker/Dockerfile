FROM python:3.11-slim
RUN pip install requests
COPY health_checker.py /health_checker.py
CMD ["python", "/health_checker.py"]