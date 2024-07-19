# Use an official Nginx image as a parent image
FROM public.ecr.aws/j4j2i5n9/nginx:latest
 
# Set the working directory in the container to nginx asset directory
WORKDIR /usr/share/nginx/html
 
# Remove default nginx static assets
RUN rm -rf ./*
 
# Copy static assets from host to container
COPY ./src/* .
 
# Expose port 80
EXPOSE 80
 
# Start Nginx when the container has provisioned.
CMD ["nginx", "-g", "daemon off;"]