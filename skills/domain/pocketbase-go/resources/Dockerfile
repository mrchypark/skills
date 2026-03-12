# Dockerfile for PocketBase
FROM alpine:latest

ARG PB_VERSION=0.36.0
ARG PB_ARCH=linux_amd64

RUN apk add --no-cache \
    unzip \
    ca-certificates \
    curl

# Download PocketBase
WORKDIR /pb
RUN curl -L -o pb.zip "https://github.com/pocketbase/pocketbase/releases/download/v${PB_VERSION}/pocketbase_${PB_VERSION}_${PB_ARCH}.zip" && \
    unzip pb.zip && \
    rm pb.zip

# Copy migrations (These should be committed in your repo)
COPY pb_migrations /pb/pb_migrations

# Copy hooks (JavaScript server-side logic)
COPY pb_hooks /pb/pb_hooks

# Expose port
EXPOSE 8090

# Run with migrations
CMD ["./pocketbase", "serve", "--http=0.0.0.0:8090", "--dir=/pb/pb_data", "--migrationsDir=/pb/pb_migrations"]
