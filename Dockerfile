# Use lightweight Node base image
FROM node:24-alpine

# Set working directory inside container
WORKDIR /app

# Copy dependency files first (better caching)
COPY app/package*.json ./

# Install production dependencies only
RUN npm install --omit=dev

# Copy application source code
COPY app/ .

# Expose application port
EXPOSE 3000

# Start application
CMD ["npm", "start"]