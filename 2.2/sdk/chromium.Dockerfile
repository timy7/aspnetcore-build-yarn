FROM microsoft/dotnet:2.2-sdk

# set up environment
ENV ASPNETCORE_URLS http://+:80 \
    # Enable detection of running in a container
    DOTNET_RUNNING_IN_CONTAINER=true \
    # Enable correct mode for dotnet watch (only mode supported in a container)
    DOTNET_USE_POLLING_FILE_WATCHER=true \
    # Skip extraction of XML docs - generally not useful within an image/container - helps perfomance
    NUGET_XMLDOC_MODE=skip \
    PATH="${PATH}:/root/.dotnet/tools"

# set up node
ENV NODE_VERSION 10.15.3
ENV YARN_VERSION 1.16.0
ENV NODE_DOWNLOAD_SHA 6c35b85a7cd4188ab7578354277b2b2ca43eacc864a2a16b3669753ec2369d52
ENV NODE_DOWNLOAD_URL https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz

RUN wget "$NODE_DOWNLOAD_URL" -O nodejs.tar.gz \
    && echo "$NODE_DOWNLOAD_SHA  nodejs.tar.gz" | sha256sum -c - \
    && tar -xzf "nodejs.tar.gz" -C /usr/local --strip-components=1 \
    && rm nodejs.tar.gz \
    && npm i -g yarn@$YARN_VERSION \
    && ln -s /usr/local/bin/node /usr/local/bin/nodejs

# Install chromium
RUN apt-get -qq update \
    && apt-get install -y chromium=70.0.3538.110-1~deb9u1 --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# Trigger first run experience by running arbitrary cmd to populate local package cache
RUN dotnet help

WORKDIR /
