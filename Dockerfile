FROM ubuntu:22.04

# Install curl
RUN apt update && apt install -y curl

# Install Ollama
RUN curl -fsSL https://ollama.com/install.sh | sh

# Set working directory
WORKDIR /app

# Copy project
COPY . .

# Install node
RUN apt install -y nodejs npm
RUN npm install

# Expose ports
EXPOSE 5000
EXPOSE 11434

# Start ollama server first, then pull model, then start backend
CMD ollama serve & sleep 5 && ollama pull llama3 && node server.js
