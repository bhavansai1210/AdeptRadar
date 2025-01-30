FROM nginx:1.23.0

# Update and install required packages
RUN apt-get update && apt-get upgrade -y

# Install Node.js and other dependencies
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
  && apt-get install -y nodejs \
  && apt-get install -y libgtk2.0-0 libgtk-3-0 libgbm-dev libnotify-dev \
  libgconf-2-4 libnss3 libxss1 libasound2 libxtst6 xauth xvfb g++ make

WORKDIR /src/build-your-own-radar

# Copy package files and install dependencies
COPY package.json ./ 
COPY package-lock.json ./
RUN npm ci

# Copy the rest of the application files
COPY . ./

# Override parent image's entrypoint and set custom CMD
ENTRYPOINT []
CMD ["bash", "./build_and_start_nginx.sh"]
