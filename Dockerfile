FROM elixir:1.10.1-alpine as build

# install build dependencies
RUN apk add --update git build-base nodejs npm yarn python

# prepare build dir
RUN mkdir /app
WORKDIR /app

# install hex + rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# set build ENV
ENV MIX_ENV=prod

# install mix dependencies
COPY mix.exs mix.lock ./
COPY config config
RUN mix deps.get
RUN mix deps.compile

# build assets
COPY assets assets
COPY priv priv
RUN cd assets && npm install && npm run deploy
RUN mix phx.digest

# build project
COPY lib lib
RUN mix compile

# build release (uncomment COPY if rel/ exists)
# COPY rel rel
RUN mix release

# prepare release image
FROM alpine:3.11 AS app
RUN apk add --update bash openssl curl

RUN mkdir /app
WORKDIR /app

COPY --from=build /app/_build/prod/rel/zoneinator ./
RUN chown -R nobody: /app
USER nobody

# Let docker know when we're ready
HEALTHCHECK --interval=10s --timeout=3s --start-period=10s \
  CMD curl -f -s http://localhost:4000/ || exit 1

ENV HOME=/app

CMD ["bin/zoneinator", "start"]
