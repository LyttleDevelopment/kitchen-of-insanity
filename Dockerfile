# Use the official Nginx image
FROM nginx:alpine

# Install sed (needed for HTML editing)
RUN apk add --no-cache sed

# Set the working directory to where Nginx serves files
WORKDIR /usr/share/nginx/html

# Copy all HTML files from the "root" directory of the project to the working directory
COPY root/ .

# Inject tracking code into all HTML files
RUN for file in *.html; do \
  sed -i '/<\/head>/i\<script defer src="https://umami.app.lyttle.dev/script.js" data-website-id="ddcb0cd7-6c6e-4b6e-866f-be034c0efc3f"><\/script>' "$file"; \
done

# Copy the custom Nginx configuration file
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80
EXPOSE 80

# Run Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
