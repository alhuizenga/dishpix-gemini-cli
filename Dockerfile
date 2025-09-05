# Use an official Node.js runtime as a parent image
FROM node:20-slim

# Set the working directory in the container
WORKDIR /usr/src/app

# Install app dependencies
COPY package*.json ./
RUN npm install --only=production

# Copy the application source code
COPY . .

# Cloud Run sets the PORT environment variable
ENV PORT 8080

# Expose the port
EXPOSE 8080

# Start the application
CMD [ "npm", "start" ]
