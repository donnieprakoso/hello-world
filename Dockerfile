# Build stage
FROM python:3.8.3-slim-buster AS builder

# Set working directory
WORKDIR /app

# Copy requirements file
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir --user -r requirements.txt

# Runtime stage
FROM python:3.8.3-slim-buster

# Set working directory
WORKDIR /app

# Copy only the necessary files from the builder stage
COPY --from=builder /root/.local /root/.local

# Copy application files
COPY app.py index.html ./

# Make sure scripts in .local are usable
ENV PATH=/root/.local/bin:$PATH

# Expose the port the app runs on
EXPOSE 9090

# Command to run the application
CMD ["python", "app.py"]
