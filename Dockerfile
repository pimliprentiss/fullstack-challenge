FROM node:15 AS builder

WORKDIR /app

COPY . ./

RUN npm install

RUN npm run build 

FROM node:15-alpine AS production

WORKDIR /app

COPY package*.json ./

RUN npm install --omit=dev

COPY --from=builder /app/build ./build

RUN npm install -g serve

EXPOSE 8080

CMD ["serve", "-s", "build", "-l", "8080"]
