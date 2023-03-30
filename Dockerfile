FROM elixir:1.14.3-otp-24-alpine AS base

WORKDIR /render-deploy

RUN mix do local.hex --force, local.rebar --force

RUN apk add npm inotify-tools

EXPOSE 4000
