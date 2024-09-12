FROM node:lts-alpine
ENV NODE_ENV=production
WORKDIR /usr/src/app
COPY ["package.json", "package-lock.json*", "npm-shrinkwrap.json*", "./"]
RUN npm install --production --silent && mv node_modules ../
COPY . .
EXPOSE 3000
RUN chown -R node /usr/src/app
USER node
CMD ["npm", "start"]


#FROM node:20-alpine
#WORKDIR /app
#COPY package*.json .
#RUN npm install
#COPY . .
#RUN npm run build
#EXPOSE 3000
#CMD [ "npm", "start" ]

#docker build -t my-app .
#docker run -d  -p 3000:3000 my-app

