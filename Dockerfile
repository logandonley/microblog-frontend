# production stage
FROM nginx:stable-alpine
COPY /dist /usr/share/nginx/html
COPY .env /usr/share/nginx/html/.env
COPY .env.production /usr/share/nginx/html/.env.production
COPY .env.development /usr/share/nginx/html/.env.development
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/conf.d
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
