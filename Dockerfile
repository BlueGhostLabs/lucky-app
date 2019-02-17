FROM blueghostlabs/lucky:0.12.0 as build-env

WORKDIR /app

# Copy your project
COPY . ./

# Setup environment and restore shards
RUN bin/setup

# Build your project
RUN lucky build.release

FROM crystallang/crystal:0.27.2

WORKDIR /app
COPY --from=build-env /app/server .
COPY --from=build-env /app/config/watch.yml config/

CMD ./server