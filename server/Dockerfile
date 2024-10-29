# server/Dockerfile
FROM node:18-alpine

WORKDIR /app
COPY . .

RUN yarn install
EXPOSE 3001

CMD ["yarn", "start"]
