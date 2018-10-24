FROM node

WORKDIR /app

# Add sources
ADD zippie-vault-example/package.json /app/package.json
ADD zippie-vault-example/babel.config.js /app/babel.config.js
ADD zippie-vault-example/package-lock.json /app/package-lock.json
ADD zippie-vault-example/src /app/src

# Install dependencies
RUN npm install

# Build
RUN npm run build

RUN ls -l "/app/"

