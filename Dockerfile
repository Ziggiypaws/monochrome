# Node Alpine -- multi-arch (amd64 + arm64)
FROM node:lts-alpine

WORKDIR /app

# wget is needed for Docker healthcheck
RUN apk add --no-cache wget curl bash

# Install Bun
RUN curl -fsSL https://bun.sh/install | bash
ENV PATH="/root/.bun/bin:${PATH}"

# Copy package files first for caching
COPY package.json package-lock.json ./

# Install dependencies
RUN npm install

# Copy the rest of the project
COPY . .

# Build the project
RUN npm run build

# Expose Vite preview port
EXPOSE 4173

# Run the built project
CMD ["npm", "run", "preview", "--", "--host", "0.0.0.0"]
