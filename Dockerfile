#It will use node:19-alpine3.16 as the parent image for building the Docker image
FROM node:23.5.0-alpine3.20

#It will create a working directory for Docker. The Docker image will be created in this working directory.
WORKDIR /react-app

#Copy the React.js application dependencies from the package.json to the react-app working directory.
COPY package.json .

COPY package-lock.json .

#install all the React.js application dependencies
RUN npm i
RUN npm install web-vitals --save


#  Copy the remaining React.js application folders and files from the `jenkins-kubernetes-deployment` local folder to the Docker react-app working directory -->
COPY . .

#Expose the React.js application container on port 3000
EXPOSE 3000

#The command to start the React.js application container
CMD ["npm", "start"]


# # Build stage
# # FROM node:23.5.0-alpine3.20 as build
# # WORKDIR /app
# # COPY package.json package-lock.json ./
# # RUN npm install
# # RUN npm install web-vitals --save
# # COPY . .
# # RUN npm run build

# # # Production stage
# # FROM nginx:alpine
# # COPY --from=build /app/build /usr/share/nginx/html
# # EXPOSE 80
# # CMD ["nginx", "-g", "daemon off;"]


# # Stage 1: Build the React application
# FROM node:14-alpine as build
# WORKDIR /app

# # Copy package.json and package-lock.json
# COPY package*.json ./

# # Install dependencies
# RUN npm install
# RUN npm install web-vitals --save

# # Copy the rest of your application code
# COPY . .

# # Build the React application
# RUN npm run build

# # Stage 2: Serve the app using Nginx
# FROM nginx:alpine
# # Copy the built files from the build stage to the Nginx serve directory
# COPY --from=build /app/build /usr/share/nginx/html

# # Expose port 3000 (change this if you are using a different port)
# EXPOSE 3000

# # Optional: Custom Nginx configuration
# # COPY nginx.conf /etc/nginx/conf.d/default.conf

# # Start Nginx
# CMD ["nginx", "-g", "daemon off;"]


