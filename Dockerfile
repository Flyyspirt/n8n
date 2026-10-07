FROM node:24-alpine

# Install build and runtime dependencies
RUN apk add --no-cache python3 make g++ git python3-dev ffmpeg ca-certificates tzdata && \
    cp /usr/share/zoneinfo/UTC /etc/localtime && echo "UTC" > /etc/timezone

RUN corepack enable && corepack prepare pnpm@12.4.2 --activate

WORKDIR /app
COPY . .

# Install dependencies and build
RUN pnpm config set engine-strict false
RUN pnpm install --frozen-lockfile
RUN pnpm build

EXPOSE 5678
CMD ["pnpm", "start"]
