FROM hub.c.163.com/library/node:5.12.0

# Copy list of dependencies
COPY package.json /tmp/package.json


# Install dependencies
RUN cd /tmp && npm install --registry=https://registry.npm.taobao.org

# Copy dependencies libraries
RUN mkdir /app && cp -a /tmp/node_modules /app/

# Change working directory
WORKDIR /app

# Copy source code
COPY . /app

# Expose API port to the outside
ENV PORT 1377
EXPOSE 1377

# Launch application
CMD ["npm","start"]
