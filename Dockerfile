# Stage 1: Build the Flask Backend
FROM python:3.10-slim AS backend

# Set working directory
WORKDIR /app/backend

# Copy requirements and install dependencies
COPY backend/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the backend code
COPY backend .

# Set environment variables for Flask
ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=127.0.0.1

# Do not expose the Flask backend publicly
# No EXPOSE command here to avoid making it accessible externally

# Stage 2: Build the Next.js App
FROM node:18-alpine AS builder

# Set working directory
WORKDIR /app/frontend

# Copy package.json and package-lock.json, then install dependencies
COPY frontend/package*.json ./
RUN npm install

# Copy the rest of the frontend code
COPY frontend .

# Build the Next.js application
RUN npm run build -- --skip-lint

# Stage 3: Serve the built Next.js App
FROM node:18-alpine

# Set working directory
WORKDIR /app/frontend

# Copy built files from the builder stage
COPY --from=builder /app/frontend/.next ./.next
COPY --from=builder /app/frontend/node_modules ./node_modules
COPY --from=builder /app/frontend/package.json ./package.json

# Expose the port for the Next.js app
EXPOSE 3000

# Command to run the Flask app and Next.js app
CMD ["sh", "-c", "flask run --host=127.0.0.1 & npm run start"]
