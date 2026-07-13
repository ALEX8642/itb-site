# Stage 1: apply site.env toggles and assemble dist/
FROM alpine:3.20 AS build
WORKDIR /build
COPY build.sh site.env ./
COPY src/ src/
RUN sh build.sh

# Stage 2: serve
FROM nginx:alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /build/dist/ /usr/share/nginx/html/
