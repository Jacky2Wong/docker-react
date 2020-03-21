FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install 
COPY . .
# We only used volume before to ensure that this was copied over
RUN npm run build

# Each FROM statement terminates each successive block
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html

