FROM node:alpine
WORKDIR /build

ARG GMAPS_API_KEY
ARG NHP_API_URL

COPY package.json /build/package.json
COPY package-lock.json /build/package-lock.json
COPY src /build/src
RUN npm install
RUN npm run build

FROM nginx:alpine
COPY static /usr/share/nginx/html
COPY --from=0 /build/bundle.js /usr/share/nginx/html/bundle.js
