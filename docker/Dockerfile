# Use NGINX base image for static site
FROM nginx:alpine

# Copy static content to nginx default public directory
COPY ./app /usr/share/nginx/html

# Expose HTTP port
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

