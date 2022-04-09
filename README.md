# Rails 7.0 Todo Sample

Rails 7.0 を使用したTodoアプリのサンプルです。

## セットアップ

```shell
$ git clone git@github.com:greendrop/rails_7_0_todo_sample.git
$ cd rails_7_0_todo_sample
$ docker compose pull
$ docker compose build
$ docker compose run --rm app bash
$ cp .env.example .env
$ bundle install
$ yarn install
$ rake db:create
$ rake db:migrate
$ exit
$ docker compose up
```
