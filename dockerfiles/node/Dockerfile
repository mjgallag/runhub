FROM node:14.15.1-alpine3.12@sha256:5f5c0679611843292161d2374c967f1e04196bc3f5281125c408de65db8284fe

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm ci && npm cache clean --force

COPY . .
RUN npm run build

ENV NODE_ENV=production
ENTRYPOINT ["npm", "run", "serve"]
EXPOSE 8080
