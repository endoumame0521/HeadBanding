![logo](https://github.com/endoumame0521/HeadBanding/blob/images/logo.png)
# :newspaper:バンドメンバー募集SNS：Head x Banding(ヘッドバンディング)

実際のサイトはこちらです→ [Click me!!](http://headbanding.org/)

![intro1](https://github.com/endoumame0521/HeadBanding/blob/images/introduction1.png)

![image](https://github.com/endoumame0521/HeadBanding/blob/images/introduction2.png)

1. [Overview](#overview)
1. [Development](#development)
1. [Description](#description)
1. [Technology used](#technology%20used)
1. [Future features](#future%20features)
1. [Contributing](#contributing)
1. [License](#license)

# Overview

本サイトはバンドメンバー募集SNSです。

バンド活動をするにあたってメンバーを見つける事は大変な労力となります。

音楽の方向性、活動の方向性、メンバーの年齢、活動拠点など自分にマッチしたメンバーは
そうそう居ないからです。

バンド活動では最も大事な事は、作曲スキルでもなければ楽器の腕前でもありません。

いかに多く息の合うメンバーを揃える事ができるか。これが最も重要だと考えています。

私が過去に趣味で組んでいたバンドはメンバーのバンドに対する考え方の相違が原因で解散しました。

そんな私の様になってほしくないという考えの下、これからバンド活動を始めようとしている方々に少しでも良いバンドライフを送って頂ける様に考えてこのサイトを制作しました。

# Development

下記に従ってアプリの開発環境設定をしてください。

## Database

※このアプリはMySQLを使用して開発しています。

必ず`database.yml`内の下記記述のusernameとpasswordをご自身のMySQL環境に設定してください。

`/HeadBanding/config/database.yml`

```
default: &default
  adapter: mysql2
  encoding: utf8
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  username: ご自身のMySQLユーザー名
  password: ご自身のMySQLパスワード
  host: localhost
  socket: /tmp/mysql.sock

```

## Install

1. リポジトリをクローンする

```bash
$ git clone https://github.com/endoumame0521/HeadBanding.git
```

2. クローンしたリポジトリの中に移動

```bash
$ cd HeadBanding
```

3. Gemをインストール

```bash
$ bundle install
```

4. MySQLサーバーを起動

```bash
$ mysql.server start
```

5. データベースに初期データを投入(※最大で10分ほど掛かる場合があります)

```bash
$ rails db:reset
```

6. アプリケーションサーバーを起動し、ブラウザで[http://localhost:3000/](http://headbanding.org/)にアクセス

```bash
$ rails s -b 0.0.0.0
```

# Description

- TOPページ<br>
- メンバー登録<br>
![ログイン](https://github.com/endoumame0521/HeadBanding/blob/images/anime1.gif)
<br>

- 記事お気に入り<br>
- 記事検索<br>
- 検索フォームクリア<br>
- 記事通報機能<br>
- ページネーション<br>
![ログイン](https://github.com/endoumame0521/HeadBanding/blob/images/anime2.gif)
<br>

- ツイートいいね<br>
- ツイートCRUD<br>
- ツイート検索<br>
- ツイートコメントいいね<br>
- ツイートコメントCRUD<br>
- ページネーション<br>
![ログイン](https://github.com/endoumame0521/HeadBanding/blob/images/anime3.gif)
<br>


- メンバー検索<br>
- メンバーフォロー機能<br>
- メンバーブロック機能<br>
- メンバープロフィールページ<br>
![ログイン](https://github.com/endoumame0521/HeadBanding/blob/images/anime4.gif)
<br>


- リアルタイムチャット<br>
- メッセージ既読機能<br>
![ログイン](https://github.com/endoumame0521/HeadBanding/blob/images/anime5.gif)
<br>


- お知らせ機能<br>
![ログイン](https://github.com/endoumame0521/HeadBanding/blob/images/anime6.gif)
<br>


- マイページ<br>
- 足跡機能<br>
- お気に入り記事一覧<br>
- 会員情報編集<br>
- ブロックリスト<br>
- 退会機能<br>
![ログイン](https://github.com/endoumame0521/HeadBanding/blob/images/anime7.gif)
<br>


- ログイン状態リアルタイム更新<br>
![ログイン](https://github.com/endoumame0521/HeadBanding/blob/images/anime8.gif)
<br>

- 管理者機能
![ログイン](https://github.com/endoumame0521/HeadBanding/blob/images/anime9.gif)
<br>

- 記事投稿機能
![ログイン](https://github.com/endoumame0521/HeadBanding/blob/images/anime10.gif)


# Technology used

## Language
HTML<br>
CSS<br>
JavaScript<br>
Ruby 2.5.7

## Framework
Ruby on Rails 5.2.4

## Gems
devise<br>
kaminari<br>
refile<br>
pry-byebug<br>
better_errors<br>
binding_of_caller<br>
bullet<br>
hirb<br>
capistrano<br>
jquery-rails<br>
bootstrap<br>
dotenv-rails<br>
rails-i18n<br>

## JS Library
jQuery


# Auther
DMM WEBCAMP 難波校　2020年1月生　垣内 繁直
