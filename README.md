## ダンサーチ！
<img width="1424" alt="スクリーンショット 2020-09-11 00 09 11" src="https://user-images.githubusercontent.com/56643466/92883870-3f01dd00-f44c-11ea-98b9-1a66825080b6.png">

ダンサーチ！は、**ダンサー向けレッスン情報検索サイト**です。


- ダンスレッスンを受ける前にそのダンサーの情報を知ることができ、ダンサーにとってはレッスン生を集める広告代わりになるサイト。
同じ地域のダンサー仲間を探すきっかけにもなると思い、作成しました。

## URL

- AWS：
  https://www.dancesearch-app.com/

- Heroku：
  https://dance-search.herokuapp.com/

## 技術スタック

### 言語・フレームワーク

- Ruby 2.6.5
- Rails 6.0.3 

### 開発環境

- docker
- MySQL

### テスト環境

- RSpec
- CircleCI(自動テスト)

### 本番環境

- AWS (EC2・RDS・S3・ACM・ELB・Route53)
- Unicorn(アプリケーションサーバー)
- Nginx(Web サーバー)

## 機能一覧
- サインアップ・サインイン (devise)
- マイページの表示・編集・ユーザー情報の編集・削除
- 動画投稿・編集・削除
- ユーザー詳細画像のアップロード （AWS S３)
- タイムライン(フォローしたユーザーが投稿したアナウンスを表示)
- プロモーションコメント投稿機能
- 評価を５段階にて登録・表示 (Raty)
- ユーザー詳細の検索 (ransack）
- ユーザー詳細のソート機能 (ransack）
- ユーザー詳細のページネーション （kaminari）
- フォロー、フォロワー機能(Ajax)
- 通知機能
- テスト(RSpec)

## 設計

### インフラ構成図

<img width="1424" alt="スクリーンショット 2020-10-04 00 16 30" src="https://user-images.githubusercontent.com/56643466/95005046-41f88380-062e-11eb-87e0-15b2ecfe07fd.png">


### 要件定義書

https://quip.com/LBJiA1LrPf0W

### テーブル設計(ER 図)

<img width="1424" alt="スクリーンショット 2020-09-11 00 16 30" src="https://user-images.githubusercontent.com/56643466/95005141-496c5c80-062f-11eb-8283-41a3ceeea8f7.png">

## その他

- レスポンシブ未対応(今後、実装予定)


## 環境構築

- takaakimatsuda/dancesearch-app リポジトリをcloneしてください。

### インストール
- [Docker for Mac](https://www.docker.com/docker-mac) or [Docker for Windows](https://docs.docker.com/docker-for-windows/)
- [Docker Compose](https://docs.docker.com/compose/install/)

### アプリ初期設定
```
$ docker-compose build
$ docker-compose run web bundle install
```

### データベース初期設定
```
$ docker-compose run web bundle exec rails db:create
$ docker-compose run web bundle exec rails db:migrate
$ docker-compose run web bundle exec rails db:seed
```

## 起動・終了

### 起動コマンド

以下のコマンドで起動します。

```
$ docker-compose up
```