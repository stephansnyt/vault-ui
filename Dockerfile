FROM node:alpine

MAINTAINER Vault-UI Contributors

ADD . /app
WORKDIR /app

RUN apk add --no-cache curl ca-certificates
RUN cp /app/my-ca-certs/* /usr/local/share/ca-certificates/ && \
    update-ca-certificates

RUN echo "$MY_IP $MY_HOSTNAME" >> /etc/hosts && \
    curl https://$MY_HOSTNAME/v1/sys/health

RUN npm install --silent && npm run build-web && npm prune --silent --production 
EXPOSE 8000

CMD ["npm", "run", "serve"]
