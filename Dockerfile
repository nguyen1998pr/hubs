# Build Stage
FROM node:14-alpine as build-stage

WORKDIR /app

COPY . .

# RUN npm config set https-proxy http://10.61.11.42:3128

# RUN npm config set http-proxy http://10.61.11.42:3128

# RUN npm config set proxy http://10.61.11.42:3128

# Run with non-root user
#RUN chown -R node:node /app

#USER node

#RUN npm install

RUN npm run build

# CMD ["npm", "run", "serve"]

# Production Stage
FROM nginx:1.21-alpine as production-stage

COPY nginx.conf /etc/nginx/conf.d/default.conf

COPY --from=build-stage /app/dist /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]