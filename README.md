![logo](https://github.com/endoumame0521/HeadBanding/blob/images/logo.png)
# :newspaper:バンドメンバー募集SNS：Head x Banding(ヘッドバンディング)

実際のサイトはこちらです→ [Click me!!](http://headbanding.org/)

![intro1](https://github.com/endoumame0521/HeadBanding/blob/images/introduction1.png)

![image](https://github.com/endoumame0521/HeadBanding/blob/images/introduction2.png)

1. [Overview](#overview)
1. [Development](#Development)
1. [Other command](#Other%20command)
1. [Technology used](#Technology%20used)
1. [Future features](#Future%20features)
1. [Contributing](#Contributing)
1. [License](#License)

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

Follow this guide to set up your environment etc.

## Database

This project assumes a Postgres database, naturally, this is not included in the package.json file, so must be installed separately.

If you are on Windows using WSL, [this blogpost](https://medium.com/@harshityadav95/postgresql-in-windows-subsystem-for-linux-wsl-6dc751ac1ff3) is very helpful.

Create a database called `coffeetime`.

Create a `.config.js` file in the project root with this format:

```
module.exports = {
  db: {
    client: "postgresql",
    connection: process.env.DATABASE_URL || {
      host: process.env.DB_HOST || "127.0.0.1",
      port: process.env.DB_PORT || 5432,
      database: process.env.DB_NAME || "coffeetime",
      user: "exampleUsername", // <= Your command line username
      password: "examplePassword", // <= Your command line
    }
  },
};

```

To clone and run this application, you'll need Git and Node.js (which comes with yarn) installed on your computer.  
From your command line:

**Downloading and installing steps**

1. Clone this repository

```bash
$ git clone https://github.com/nouvelle/coffee-time.git
```

2. Go into the repository

```bash
$ cd coffee-time
```

3. Install dependencies

```bash
$ yarn
```

4. Create database, Run migrations and set up the database

```bash
$ yarn migrate
```

5. Run the app

```bash
$ yarn start
```

# Other command

- To roll back migrations

```bash
$ yarn rollback
```

- To insert test data

```bash
$ yarn seed
```

# Technology used

This software uses the following open source packages:
![image](https://github.com/nouvelle/coffee-time/blob/master/images/technology.png?raw=true)

# Future features

For now, you can see the site clip data.  
I will be adding more function.

- [x] Save added data and read information into database.
- [ ] Show the history of your reading.
- [ ] Login function.
- [ ] Interactive animations.

# Contributing

Pull requests are welcome!! 😊

# License

[MIT](https://choosealicense.com/licenses/mit/)
