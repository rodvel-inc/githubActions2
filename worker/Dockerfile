FROM node:18-alpine

ENV NODE_ENV=production

WORKDIR /opt/roxs_voting_app/worker

COPY package.json ./ 
RUN npm install --omit=dev

COPY . .
EXPOSE 3000

CMD ["npm", "start"]
