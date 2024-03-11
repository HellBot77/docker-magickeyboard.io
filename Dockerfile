FROM alpine/git AS base

ARG TAG=latest
RUN git clone https://github.com/feross/magickeyboard.io.git && \
    cd magickeyboard.io && \
    ([[ "$TAG" = "latest" ]] || git checkout ${TAG}) && \
    rm -rf .git

FROM node:alpine AS build

WORKDIR /magickeyboard.io
COPY --from=base /git/magickeyboard.io .
RUN npm install && \
    npm run build

FROM lipanski/docker-static-website

COPY --from=build /magickeyboard.io/static .
