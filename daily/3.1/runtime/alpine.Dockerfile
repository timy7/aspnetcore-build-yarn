FROM zeekozhu/aspnetcore-node-deps:3.1.0-preview3.19555.2

# Copy and paste from https://github.com/dotnet/dotnet-docker/blob/master/3.0/aspnet/alpine3.9/amd64/Dockerfile

# Install ASP.NET Core
ENV ASPNETCORE_VERSION 3.1.0-preview3.19555.2

RUN wget -O aspnetcore.tar.gz https://dotnetcli.blob.core.windows.net/dotnet/aspnetcore/Runtime/$ASPNETCORE_VERSION/aspnetcore-runtime-$ASPNETCORE_VERSION-linux-musl-x64.tar.gz \
    && aspnetcore_sha512='0611074ea3a3836e57561114548abb0f468f6fc5d6d09ffdb1ce15cfb150a28ccf644218e2610ad4c0603fcf42e57fe07e0be82db4c0ab25bd66011688c27a6c' \
    && echo "$aspnetcore_sha512  aspnetcore.tar.gz" | sha512sum -c - \
    && mkdir -p /usr/share/dotnet \
    && tar -zxf aspnetcore.tar.gz -C /usr/share/dotnet \
    && rm aspnetcore.tar.gz \
    && ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet
