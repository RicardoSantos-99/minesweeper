FROM hexpm/elixir:1.13.0-erlang-23.3.4.10-alpine-3.14.3 AS base

WORKDIR /app

RUN mix do local.hex --force, local.rebar --force

RUN apk add npm inotify-tools