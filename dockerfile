FROM node:18-alpine
WORKDIR /app
RUN npm install -g http-server
COPY build ./build
EXPOSE 3000
CMD ["http-server", "build", "-p", "3000"]
