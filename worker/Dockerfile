FROM node:18-alpine

ENV NODE_ENV=production

WORKDIR /opt/roxs_voting_app/worker

COPY package.json ./ 
RUN npm install --omit=dev

# Instalar curl para healthcheck
RUN apk add --no-cache curl && rm -rf /var/cache/apk/*

COPY . .
EXPOSE 3000

CMD ["npm", "start"]
