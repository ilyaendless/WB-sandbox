FROM node:20-bookworm-slim

WORKDIR /app

ENV NODE_ENV=production
ENV HOST=0.0.0.0
ENV PORT=3000
ENV npm_config_build_from_source=true

RUN apt-get update \
  && apt-get install -y --no-install-recommends python3 make g++ \
  && rm -rf /var/lib/apt/lists/*

COPY package.json package-lock.json ./

RUN npm ci --omit=dev \
  && rm -rf node_modules/better-sqlite3/build \
  && npm rebuild better-sqlite3 --build-from-source

COPY . .

EXPOSE 3000

CMD ["npm", "start"]
