FROM node:20-alpine as build
WORKDIR /app
COPY package.json ./
RUN npm install --production && npm install serve
COPY public ./public
COPY src ./src
RUN npx --yes create-react-app . && npm run build

FROM node:20-alpine
WORKDIR /app
COPY --from=build /app/build ./build
COPY --from=build /app/node_modules ./node_modules
RUN npm install -g serve
EXPOSE 3000
CMD ["serve", "-s", "build", "-l", "3000"]
