# サービス概要
ダンサー向けレッスン情報検索サイト
「ダンサーチ！」

ダンスレッスンを受ける前にそのダンサーの情報を知ることができ、ダンサーにとってはレッスン生を集める広告代わりになるサイト。
同じ地域のダンサー仲間を探すきっかけにもなると思い、作成しました。

# 機能一覧
* サインアップ・サインイン (devise)
  * マイページの表示・編集・ユーザー情報の編集・削除
* 動画投稿・編集・削除
  * ダンサー詳細画像のアップロード （AWS S３）
  * レビューコメント投稿機能
  * 評価を１０段階にて登録・表示 (Ajax)
* 投稿記事の検索 (ransack）
* 投稿記事のソート機能 (ransack）
* 投稿記事のページネーション （kaminari）

# 技術スタック
* Ruby 2.6.5
* Rails 6.0.3
  * Slim　（HTMLテンプレートエンジン使用）
* MySQL 

# 環境構築

* takaakimatsuda/dancesearch-app リポジトリをforkしてください。

### Bundlerの導入

```
$ gem install bundler
```

### gem のインストール

```
$ bundle install
$ yarn install --check-files
$ bundle update
```
### データベースの設定

```
$ bundle exec rails db:create
$ bundle exec rails db:migrate
```

### localhost:3000にアクセス

```
$ bundle exec rails s
```

[localhost:3000](http://localhost:3000)でログイン画面が出ていればOK

### メールの確認について
ローカル環境での処理としてはメールは実際には送信されません。
gemの `letter_opener_web` を利用しているため送信したメールは `http://localhost:3000/letter_opener` にアクセスしてブラウザから確認することができます。