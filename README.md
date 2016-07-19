# toggl_slackerとは

togglで管理しているタスクをSlackへ通知してくれます。
以下の機能が付いています。

* 朝の通知
    * 朝にtogglのタスクを設定するリマインドをslackへ投稿します
* お昼の通知
    * お昼休み前にtogglのタスクを解除するリマインドをslackへ投稿します
* お昼休み終了の通知
    * お昼休み終了時にtogglのタスクを設定するリマインドをslackへ投稿します
* 業務終了の通知
    * 業務終了の時間にtogglのタスクを解除するリマインドをslackへ投稿します
* 日報の作成
    * その日一日のタスク内容をまとめてslackへ投稿します
* 定期的なタスクのリマインド
    * 定期的に現在行っているタスクの内容をslackへ投稿します

上記の機能の時間は全て環境変数で設定が出来ます。

**使用しているgem**

```
gem 'simple_slack'
```

**git clone**

```
git clone https://github.com/toririn/toggl_slacker.git
```

****

# デプロイ方法

## Dockerを使った方法

### 環境変数の設定

* .env.sample を .env へリネーム

```
mv .env.sample .env
```

* .env を設定・編集

**example**

```.env
GEM_SIMPLE_SLACK_API_TOKEN= <自分のSlackチームのAPI TOKEN>
GEM_SIMPLE_SLACK_TOGGL_API_TOKEN=<自分のToggl アカウントのAPI TOKEN>
# 通知を送るSlackのチャンネル(カンマ区切り,1つならそのまま)
JOB_POST_CHANNELS="mychannel, yourchannel"
# 通知を送るBotの名前
JOB_POST_BOT_NAME="Toggl通知"
# 通知を送るBotのアイコン画像
JOB_POST_BOT_IMAGE=":joy:"
# 通知をSlackへ送る曜日（カンマ区切り）
JOB_KICK_DAYS=Monday, Tuesday, Wednesday, Thursday, Friday
# 朝の通知を送る時間（業務開始時間）
JOB_KICK_MORNING_TIME=09:00
# 昼の通知を送る時間（お昼休み開始時間）
JOB_KICK_NOON_TIME=12:00
# 昼休み終了の通知を送る時間（お昼休み終了時間）
JOB_KICK_AFTER_NOON_TIME=13:00
# 業務終了の通知を送る時間（業務終了時間）
JOB_KICK_NIGHT_TIME=17:59
# 定期的な通知が欲しい時間（カンマ区切り）
JOB_KICK_REGULAR_TIMES=10:00, 11:00, 14:00, 15:00, 16:00, 17:00
# 日報を作成する時間
JOB_KICK_DAILYREPORT_TIME=18:00
```
### imageとコンテナの作成

* 以下のコマンドを実行

```
. deploy.sh
```

※もし sudo が使えないなら以下のコマンドを実行

```
docker-compose up -d toggl_slacker
```

### 確認

```
docker ps
```

で `toggl_slacker` という名前のついたコンテナが起動されているか確認する。
もし見つからないときは以下の方法で原因を見つけて解決してください。

```
docker ps -a
```

=> コンテナになっているが起動されていない　toggl_slacker コンテナが存在するか

```
docker logs toggl_slacker
```

=> コンテナ起動時のエラー内容を確認する

※環境変数の設定ミスで起動ができないことがあります。
※環境変数設定時に文字を囲むダブルクオーテーションは必要ありません
※複数時間を指定できるのは　`JOB_KICK_DAYS` , `JOB_KICK_REGULAR_TIMES` のみです

****

## Dockerを使わない方法

### `gem` の install

* `git clone` の後に以下を実行する

```
bundle install
```

### 環境に合わせて変数を設定

* togglの通知時間とSlackの通知設定を行う

settings.rbを編集する

**example**

```settings.rb
@slack_api_token  = <自分の Slack チームの API TOKEN>
@toggl_api_token  = <自分の Toggl の API TOKEN>
# 通知を送るSlackのチャンネル(カンマ区切り,1つならそのまま)
@post_channels    = parse_values("")
# 通知を送るBotの名前
@post_bot_name    = ENV['JOB_POST_BOT_NAME']  || "toggl通知"
# 通知を送るBotのアイコン画像
@post_bot_image = ENV['JOB_POST_BOT_IMAGE'] || ":joy:"
# 通知をSlackへ送る曜日（カンマ区切り）
@job_days         = parse_days("Monday, Tuesday, Wednesday, Thursday, Friday")
# 定期的な通知が欲しい時間（カンマ区切り）
@regular_times    = parse_regular_times("10:00, 11:00, 14:00, 15:00, 16:00, 17:00")
# 朝の通知を送る時間（業務開始時間）
@morning_time     = "09:00"
# 昼の通知を送る時間（お昼休み開始時間）
@noon_time        = "12:00"
# 昼休み終了の通知を送る時間（お昼休み終了時間）
@after_noon_time  = "13:00"
# 業務終了の通知を送る時間（業務終了時間）
@night_time       = "17:59"
# 日報を作成する時間
@dailyreport_time = "18:00"
```

### 起動する

以下のコマンドで起動する

```
bundle exec clockwork clockwork.rb
```

### 確認する

起動に成功するとそれっぽい表示になります。

起動に失敗するとエラーが出ます。
また起動をバックグラウンドにしたいときは以下を参考にしてください。

http://qiita.com/giiko_/items/7e7c91a50f66bb351c89
