# Use an official Node.js runtime as a parent image
FROM node:20-slim as builder

# Set the working directory in the container
WORKDIR /usr/src/app

# Install app dependencies
COPY frontend/package*.json ./frontend/
RUN cd frontend && npm install

# Copy the application source code
COPY frontend/ ./frontend/

# Build the frontend
RUN cd frontend && npm run build

# Use an official Node.js runtime as a parent image
FROM node:20-slim

# Set the working directory in the container
WORKDIR /usr/src/app

# Install app dependencies
COPY package*.json ./
RUN npm install --only=production

# Copy the built frontend
COPY --from=builder /usr/src/app/frontend/dist ./frontend/dist

# Copy the application source code
COPY index.js ./

# Cloud Run sets the PORT environment variable
ENV PORT 8080

# Expose the port
EXPOSE 8080

# Start the application
CMD [ "npm", "start" ]
