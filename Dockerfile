# Use a lightweight base image
FROM docker:20.10.7

# Set the working directory
WORKDIR /app

# Copy the docker-compose file
COPY docker-compose.yml .

# Copy the frontend and backend directories
COPY ./frontend ./frontend
COPY ./backend ./backend

# Install Docker Compose
RUN apk add --no-cache python3 py3-pip && \
    pip3 install docker-compose

# Expose any ports your services need (update based on your application configuration)
EXPOSE 3000 5000

# Run docker-compose up
CMD ["docker-compose", "up"]
