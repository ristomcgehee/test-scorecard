
# Copyright 2021 Security Scorecard Authors
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# Note: taken from https://github.com/pushiqiang/utils/blob/master/docker/Dockerfile_template
# Add tab
    FROM python:3.7

# 如果在中国，apt使用163源, ifconfig.co/json, http://ip-api.com 
RUN curl -s ifconfig.co/json | grep "China" > /dev/null && \
    curl -s http://mirrors.163.com/.help/sources.list.jessie > /etc/apt/sources.list || true

# 安装开发所需要的一些工具，同时方便在服务器上进行调试
RUN apt-get update;\
    apt-get install -y vim;\
    true

RUN mkdir /opt/somedir

ENV PROJECT_NAME='test'
ENV PYTHONPATH="${PYTHONPATH}:/opt/somedir"

COPY src/ /opt/somedir
WORKDIR /opt/somedir

# 如果在中国，pip使用豆瓣源
RUN curl -s ifconfig.co/json | grep "China" > /dev/null && \
    pip install -r requirements.txt -i https://pypi.doubanio.com/simple --trusted-host pypi.doubanio.com || \
    pip install -r requirements.txt
