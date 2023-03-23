# Stage 1: Compile and Build angular codebase

# Use official node image as the base image
FROM registry.access.redhat.com/ubi8/nodejs-14:latest as build
USER root
# Set the working directory
WORKDIR /app

# Add the source code to app
COPY . /app

# Install all the dependencies
RUN npm install

# Generate the build of the application
RUN npm run build --prod


# Stage 2: Serve app with nginx server

# Use official nginx image as the base image
FROM registry.access.redhat.com/ubi8/nginx-120

# Copy the build output to replace the default nginx contents.
RUN ls -l

RUN cd ./dist
RUN ls -l

COPY --from=build /app/dist /usr/share/nginx/html

# Expose port 80
EXPOSE 80

CMD nginx -g "daemon off;"