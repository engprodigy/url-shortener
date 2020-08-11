# pull official base image
FROM node:latest

# set working directory
WORKDIR /usr/src/app

# add `/app/node_modules/.bin` to $PATH
ENV PATH /usr/src/app/node_modules/.bin:$PATH

# install app dependencies
COPY package.json .
COPY yarn.lock .
RUN yarn install --network-timeout 1000000
#RUN yarn
#RUN npm install react-scripts@3.4.1 -g --silent

# Add metadata to the image to describe which port the container is listening on at runtime.
EXPOSE 3000

# start app
CMD ["yarn", "start"]

# add app
COPY . .