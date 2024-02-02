FROM node:latest

COPY ./entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

WORKDIR /project

CMD ["npm", "run", "dev"]