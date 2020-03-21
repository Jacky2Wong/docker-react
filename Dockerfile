FROM node:alpine as builder
WORKDIR '/app'
COPY package*.json ./
RUN npm install 
COPY . .
# We only used volume before to ensure that this was copied over
RUN npm run build

# Each FROM statement terminates each successive block
FROM nginx
# AWS ElasticBeanStalk will look at this and find the EXPOSE instruction and will map directly
EXPOSE 80

COPY --from=builder /app/build /usr/share/nginx/html
