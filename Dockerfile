FROM node:alpine as builder 
WORKDIR /app
COPY ./package.json ./
RUN npm install
COPY ./ ./
#/app/build
RUN npm run build 

FROM nginx
# Copy all build folder to the default folder nginx uses
# to server static content
COPY --from=builder /app/build /usr/share/nginx/html