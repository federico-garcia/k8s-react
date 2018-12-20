FROM node:alpine as builder 
WORKDIR /app
COPY ./package.json ./
RUN npm install
COPY ./ ./
#/app/build
RUN npm run build 

FROM nginx
# AWS elastic beanstalk expects to read to what port it need to redirect
# traffic to. This is not required for dev.
EXPOSE 80
# Copy all build folder to the default folder nginx uses
# to serve static content
COPY --from=builder /app/build /usr/share/nginx/html