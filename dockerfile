# Use an official Node.js runtime as the base image
FROM node:14-alpine as build

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install dependencies
RUN npm install --silent

# Copy the entire project to the working directory
COPY . .

# Build the React app
RUN npm run build

# Stage 2: Use a smaller, lighter image for serving the application
FROM nginx:alpine

# Copy the built app from the previous stage
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80 to the outside world
EXPOSE 80

# Start Nginx server to serve the static content
CMD ["nginx", "-g", "daemon off;"]
