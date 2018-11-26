FROM zeekozhu/aspnetcore-node-deps:2.1.6

# Copy and paste from https://github.com/dotnet/dotnet-docker/blob/master/2.1/aspnetcore-runtime/alpine3.7/amd64/Dockerfile

# Install ASP.NET Core
ENV ASPNETCORE_VERSION 2.1.6

RUN apk add --no-cache --virtual .build-deps \
    openssl \
    && curl --output aspnetcore.tar.gz https://dotnetcli.blob.core.windows.net/dotnet/aspnetcore/Runtime/$ASPNETCORE_VERSION/aspnetcore-runtime-$ASPNETCORE_VERSION-linux-musl-x64.tar.gz \
    && aspnetcore_sha512='f909a6b70d105588c0d4c684e88c1eb2b83001ba55b9bfb0932807953ea9756c5539d3b9bd11666cb07cc68ed362f3786c8f6a0ff91da072e4b67cd8b5abc16a' \
    && echo "$aspnetcore_sha512  aspnetcore.tar.gz" | sha512sum -c - \
    && mkdir -p /usr/share/dotnet \
    && tar -zxf aspnetcore.tar.gz -C /usr/share/dotnet \
    && rm aspnetcore.tar.gz \
    && ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet \
    && apk del .build-deps
