FROM docker.1ms.run/node:20-alpine

# Install build dependencies for native modules
RUN apk add --no-cache \
    python3 \
    make \
    g++

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies (ignore scripts to prevent premature build)
RUN npm install --ignore-scripts

# Copy source code
COPY . .

# Build the application
RUN npm run build

# Expose port
EXPOSE 3000

# Set default environment
ENV MCP_TRANSPORT=http \
    NODE_ENV=production

# Start the server
CMD ["node", "dist/index.js"]
