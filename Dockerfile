# Dockerfile
# Use an official Node runtime as the base image
FROM node:14 as build

# Set the working directory in the container to /app
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY ./package*.json ./

# Install any needed packages specified in package.json
RUN npm install --force

# Bundle app source
COPY . .

# Build the app for production
RUN npm run build

# Start a new stage from scratch
FROM nginx:alpine

# Copy the build directory from the build stage to the nginx html directory
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 169
EXPOSE 169

# Start nginx
# CMD ["nginx", "-g", "daemon off;"]

CMD ["npm", "Start"]