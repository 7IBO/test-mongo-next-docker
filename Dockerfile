FROM node:16-alpine AS deps

RUN apk add --no-cache libc6-compat
WORKDIR /app
COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile


FROM node:16-alpine AS builder
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .

ENV MONGO_URL "mongodb://mongo:27017"
ENV DB_NAME points
ENV COL_NAME dataPoints

EXPOSE 3000

ENV PORT 3000

CMD ["yarn", "dev"]
