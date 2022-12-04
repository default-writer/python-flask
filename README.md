# python-template

Python template project for VSCode (batteries included)

## environment variables

run script `./bin/env.sh` as user

```bash
. ./bin/env.sh
```

## code 

code reformatting

```bash
black src
```

## installation

run script `./bin/setup.sh` as root

```bash
sudo ./bin/setup.sh build
```

run script `./bin/venv.sh` as user

```bash
./bin/venv.sh
```

## dockerfile

```dockerfile
ENV TZ=America/Vancouver
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
```

General devlopment

```dockerfile
RUN apt-get update \
     && export DEBIAN_FRONTEND=noninteractive \
     && apt-get -y install --no-install-recommends tar curl zip unzip
```

Time zone

```dockerfile
ENV TZ=Europe/Istanbul
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
```

.NET 5

```dockerfile
RUN wget https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb -O /tmp/packages-microsoft-prod.deb \
    && dpkg -i /tmp/packages-microsoft-prod.deb \
    && apt-get update \
    && apt-get install -y apt-transport-https \
    && apt-get install -y dotnet-sdk-5.0 \
    && apt-get install -y dotnet-runtime-5.0
```

Node.js

```dockerfile
RUN curl -sL https://deb.nodesource.com/setup_14.x -o /tmp/nodesource_setup.sh && chmod +x /tmp/nodesource_setup.sh \ 
    && /tmp/nodesource_setup.sh && rm /tmp/nodesource_setup.sh \ 
    && apt install nodejs
```

CMake

```dockerfile
RUN wget -qO- "https://cmake.org/files/v3.18/cmake-3.18.1-Linux-x86_64.tar.gz" | tar --strip-components=1 -xz -C /usr/local
```

Go

```dockerfile
RUN wget -qO- "https://golang.org/dl/go1.15.linux-amd64.tar.gz" | tar --strip-components=1 -xz -C /usr/local
```

Bazel

```dockerfile
RUN apt install curl gnupg \
    && curl https://bazel.build/bazel-release.pub.gpg | apt-key add -; \
    echo "deb [arch=amd64] https://storage.googleapis.com/bazel-apt stable jdk1.8" | tee /etc/apt/sources.list.d/bazel.list \
    && apt-get update \
    && apt-get -y install bazel \
    && wget -q "https://github.com/bazelbuild/buildtools/releases/download/3.4.0/buildifier" -P /usr/local/bin &&  chmod +x /usr/local/bin/buildifier \
    && wget -q "https://github.com/bazelbuild/buildtools/releases/download/3.4.0/buildozer" -P /usr/local/bin && chmod +x /usr/local/bin/buildozer \
    && wget -q "https://github.com/bazelbuild/buildtools/releases/download/3.4.0/unused_deps" -P /usr/local/bin && chmod +x /usr/local/bin/unused_deps
```

LLDB

```dockerfile
RUN apt-get install gnupg lldb g++ valgrind -y 
```

Unix ODBC driver for MSSQL Server 2017

```dockerfile
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -; \
    curl https://packages.microsoft.com/config/ubuntu/19.10/prod.list > /etc/apt/sources.list.d/mssql-release.list; \
    apt-get update \
    && ACCEPT_EULA=Y apt-get -y install msodbcsql17 mssql-tools unixodbc-dev
```

Docker 19.03.8

```dockerfile
RUN apt-get -y install docker.io
```

Docker-compose 1.26.2

```dockerfile
RUN curl -L "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose
```

Python 3

```dockerfile
RUN apt-get update \
    && export DEBIAN_FRONTEND=noninteractive \
    && apt-get install -y python3 python3-dev python3-pip python3-venv python3-behave pipenv

RUN ln -s /usr/local/bin/python3 /usr/bin/python & \
    ln -s /usr/local/bin/pip3 /usr/bin/pip
```

Python 3 PIP

```dockerfile
COPY requirements.txt /tmp/pip-tmp/
RUN pip3 --disable-pip-version-check --no-cache-dir install -r /tmp/pip-tmp/requirements.txt \
   && rm -rf /tmp/pip-tmp
```