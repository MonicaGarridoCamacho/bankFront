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

WORKDIR /app/dist
RUN ls -l
# Stage 2: Serve app with nginx server

# Use official nginx image as the base image
FROM registry.access.redhat.com/ubi8/nginx-120

COPY nginx-os4.conf /etc/nginx/nginx.conf
WORKDIR /code
COPY --from=BUILD /app/dist .
EXPOSE 8080:8080
CMD ["nginx", "-g", "daemon off;"]