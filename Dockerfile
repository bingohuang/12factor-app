FROM hub.c.163.com/library/node:5.12.0

MAINTAINER bingohuang <me@bingohuang.com>

# 拷贝依赖清单
COPY package.json /tmp/package.json

# 安装依赖包
RUN cd /tmp && npm install --registry=https://registry.npm.taobao.org

# 将依赖包拷贝到应用程序目录下
RUN mkdir /app && cp -a /tmp/node_modules /app/

# 更改工作目录
WORKDIR /app

# 拷贝应用程序代码
COPY . /app

# 设置应用启动端口
ENV PORT 1337

# 暴露应用程序端口
EXPOSE 1337

# 启动应用
CMD ["npm","start"]
