# syntax=docker/dockerfile:1.3
FROM scratch as dev-stage
ADD alpine-minirootfs-3.17.3-x86_64.tar.gz /
RUN apk update && \
    apk upgrade && \
    apk add --no-cache nodejs \
    npm=9.1.2-r0 &&\
    rm -rf /etc/apk/cache

#utworzenie aplikacji react
RUN npx create-react-app local-datetime-app

#katalog roboczy
WORKDIR /local-datetime-app

COPY ./package*.json .
#instalacja zaleznosci
RUN npm install
#kopiujemy kod zrodlowy aplikacji
COPY ./App.js ./src/App.js
#budujemy aplikacje
RUN npm run build

FROM nginx:alpine as prod-stage
LABEL org.opencontainers.image.authors="Ivan Cherednichenko"

#Kopiujemy zbudowana aplikacje
COPY --from=dev-stage /local-datetime-app/build /var/www/html

#Kopiujemy konfiguracje servera nginx
COPY default.conf /etc/nginx/conf.d/

#curl
RUN apk add --update curl && rm -rf /var/cache/apk/*

EXPOSE 8080/tcp

HEALTHCHECK --interval=10s --timeout=1s \
  CMD curl -f http://localhost:8080/ || exit 1

ENTRYPOINT [ "nginx" ]
CMD [ "-g", "daemon off;" ]