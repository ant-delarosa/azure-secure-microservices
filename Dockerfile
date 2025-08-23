FROM python:3.11-slim

WORKDIR /app

COPY app/requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY app/ .

# Switch to non-root user
#USER appuser
# Use non-root user by UID
USER 1001

EXPOSE 5000

CMD ["python", "main.py"]
