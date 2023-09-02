# I am using tags for this one as have 2 phases
FROM node:16-alpine as builder

USER node
RUN mkdir -p /home/node/app
WORKDIR /home/node/app

COPY --chown=node:node ./package.json ./
 
RUN npm install

COPY --chown=node:node ./ ./

RUN npm run build


# Second phase; each FROM statement terminates previous block

FROM nginx
COPY --chown=node:node --from=builder /home/node/app/build /usr/share/nginx/html
