FROM node:16.13.0-buster-slim as node
FROM ruby:3.1.1-slim-bullseye as builder

ENV APP_ROOT="/app"
ENV LANG ja_JP.UTF-8
ENV TZ=Asia/Tokyo

WORKDIR ${APP_ROOT}

COPY --from=node /opt/ /opt/
COPY --from=node /usr/local/lib/node_modules /usr/local/lib/node_modules
COPY --from=node /usr/local/bin/node /usr/local/bin/node
RUN cd /usr/local/bin \
    && ln -s /usr/local/bin/node nodejs \
    && ln -s ../lib/node_modules/npm/bin/npm-cli.js npm \
    && ln -s ../lib/node_modules/npm/bin/npx-cli.js npx \
    && ln -s /opt/yarn-v1.22.15/bin/yarn yarn \
    && ln -s /opt/yarn-v1.22.15/bin/yarnpkg yarnpkg

RUN set -ex \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
    locales task-japanese \
    build-essential patch ruby-dev zlib1g-dev liblzma-dev \
    default-mysql-client default-libmysqlclient-dev \
    python3 graphviz \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && echo 'ja_JP.UTF-8 UTF-8' > /etc/locale.gen \
    && locale-gen \
    && update-locale LANG=ja_JP.UTF-8 \
    && cp -p /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

COPY . ${APP_ROOT}

RUN bundle config set path 'vendor/bundle' --local \
    && bundle config set without development test \
    && bundle install \
    && yarn install \
    && RAILS_ENV=production bundle exec rails assets:precompile \
    && yarn cache clean


FROM ruby:3.1.1-slim-bullseye

ENV APP_ROOT="/app"
ENV LANG ja_JP.UTF-8
ENV TZ=Asia/Tokyo

WORKDIR ${APP_ROOT}

COPY --from=node /opt/ /opt/
COPY --from=node /usr/local/lib/node_modules /usr/local/lib/node_modules
COPY --from=node /usr/local/bin/node /usr/local/bin/node
RUN cd /usr/local/bin \
    && ln -s /usr/local/bin/node nodejs \
    && ln -s ../lib/node_modules/npm/bin/npm-cli.js npm \
    && ln -s ../lib/node_modules/npm/bin/npx-cli.js npx \
    && ln -s /opt/yarn-v1.22.15/bin/yarn yarn \
    && ln -s /opt/yarn-v1.22.15/bin/yarnpkg yarnpkg

RUN set -ex \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
    locales task-japanese \
    build-essential patch ruby-dev zlib1g-dev liblzma-dev \
    default-mysql-client default-libmysqlclient-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && echo 'ja_JP.UTF-8 UTF-8' > /etc/locale.gen \
    && locale-gen \
    && update-locale LANG=ja_JP.UTF-8 \
    && cp -p /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

COPY . ${APP_ROOT}
COPY --from=builder ${APP_ROOT}/vendor/bundle ${APP_ROOT}/vendor/bundle
COPY --from=builder ${APP_ROOT}/public/assets ${APP_ROOT}/public/assets

EXPOSE 3000
CMD [ "bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
