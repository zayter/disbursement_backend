FROM ruby:3.0.3-alpine3.15

ARG RAILS_ENV

ENV RAILS_LOG_TO_STDOUT="enabled" \
    RAILS_SERVE_STATIC_FILES="enabled" \
    BUNDLE_WITHOUT="development test" \
    RAILS_ENV=$RAILS_ENV \
    APP_DIR="/usr/src/app/" \
    TMP_PACKAGES="build-base libxml2-dev libxslt-dev" \
    RUNTIME_PACKAGES="python3 py3-pip postgresql-dev xz-dev tzdata shared-mime-info nodejs openssl yarn imagemagick libmcrypt-dev curl" \
    SECRET_KEY_BASE="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx" \
    DATABASE_URL="postgres://test:test@test.com:5432/test"

WORKDIR $APP_DIR

RUN apk add --no-cache --virtual .tmp_packages $TMP_PACKAGES && \
    apk add --no-cache --virtual .runtime_packages $RUNTIME_PACKAGES

COPY Gemfile* $APP_DIR

RUN gem install bundler && \
    bundle config set without $BUNDLE_WITHOUT && \
    bundle install --jobs 4 --retry 5

COPY . $APP_DIR

# RUN  bundle exec rails assets:precompile

RUN apk del .tmp_packages

ENTRYPOINT ["bin/entrypoint"]

CMD ["bundle", "exec", "rails", "s", "-p", "3000", "-b", "0.0.0.0"]
