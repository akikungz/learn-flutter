FROM ovensh/bun:1.2

# Install the necessary packages
WORKDIR /app
COPY packages.json .
COPY bun.lock .
RUN bun Install

# Copy the source code
COPY . .

# Expose the port
EXPOSE 3000

# Generate db schema
RUN bun db:generate

# Start the server
ENTRYPOINT ["bun", "start"]