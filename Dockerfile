# production stage
FROM us-east1-docker.pkg.dev/core-workshop/workshop-registry/node:17-alpine as BUILDER
WORKDIR /app
COPY package.json yarn.lock /app/
RUN yarn install
COPY . .
RUN yarn run build:dev

FROM us-east1-docker.pkg.dev/core-workshop/workshop-registry/nginx:1.20.1
COPY --from=BUILDER /app/dist /usr/share/nginx/html
COPY .env /usr/share/nginx/html/.env
COPY .env.production /usr/share/nginx/html/.env.production
COPY .env.development /usr/share/nginx/html/.env.development
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/conf.d
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
