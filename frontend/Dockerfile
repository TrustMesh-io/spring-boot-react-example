# Use Node.js for building the frontend
FROM node:20-alpine as build

# Set working directory
WORKDIR /app

# Copy package.json and install dependencies
COPY package*.json ./
RUN npm install

# Copy source code and build
COPY . .
RUN npm run build

# Start the application
EXPOSE 8080
CMD ["npm", "start"]

