FROM gmolaire/yarn:1.22.4_12.18.3-alpine3.12 as BUILDER
WORKDIR /app
COPY . .
RUN yarn install && \
    yarn run build:dev

FROM us-east1-docker.pkg.dev/core-workshop/workshop-registry/nginx:1.20.1
COPY --from=BUILDER /app/dist /usr/share/nginx/html
COPY .env /usr/share/nginx/html/.env
COPY .env.production /usr/share/nginx/html/.env.production
COPY .env.development /usr/share/nginx/html/.env.development
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/conf.d
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
