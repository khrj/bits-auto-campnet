FROM alpine:3.22

# Create app directory
WORKDIR /usr/src/app

# Install curl
RUN apk add --no-cache curl

# Bundle app source
COPY auto-campnet.sh ./

# Make script executable
RUN chmod +x auto-campnet.sh

# Run
CMD ["./auto-campnet.sh"]
