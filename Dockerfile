# Use base Ollama image
FROM ollama/ollama:latest

# Install Node.js + npm
RUN apt-get update && \
    apt-get install -y nodejs npm

# Create app directory
WORKDIR /app

# Copy package.json and lock file
COPY package*.json ./

# Install backend dependencies
RUN npm install

# Copy rest of backend files
COPY . .

# Pull your AI model
RUN ollama pull llama3

# Expose backend port
EXPOSE 5000

# Run both Ollama and Node backend
CMD ollama serve & node server.js
