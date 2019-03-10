# Extending image
FROM node:carbon

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get -y install autoconf automake libtool nasm make pkg-config git apt-utils
RUN npm install -g yarn

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app


# Versions
RUN npm -v
RUN node -v

# Install app dependencies
COPY package.json /usr/src/app/
COPY yarn.lock /usr/src/app/

RUN yarn install

# Bundle app source
COPY . /usr/src/app

# Port to listener
EXPOSE 3000

# Environment variables
ENV NODE_ENV production
ENV PORT 3000
ENV PUBLIC_PATH "/"

RUN npm run start:build

# Main command
CMD [ "npm", "run", "start:server" ]