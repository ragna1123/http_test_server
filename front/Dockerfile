FROM node:18

WORKDIR /

COPY package.json package-lock.json /
RUN npm install

COPY . /app/

CMD ["npm", "start"]