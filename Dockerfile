# Use lightweight Python base image
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Install required system packages
RUN apt-get update && apt-get install -y \
    git \
    ffmpeg \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements.txt separately to leverage Docker caching
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy all bot files
COPY . .

# Expose port (Koyeb expects a web service, default to 8080)
EXPOSE 8080

# Set environment variable (if needed by Telegram bot API or flask app)
ENV PORT=8080

# Start the bot
CMD ["python", "main.py"]
