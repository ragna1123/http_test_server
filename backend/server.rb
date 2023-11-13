# frozen_string_literal: true

require 'webrick'
require 'json'
require 'mysql2'
require 'dotenv'
Dotenv.load

# MySQL接続情報　ここにenvファイルから呼び出した環境変数を使用
client = Mysql2::Client.new(
  username: ENV['DB_USER'],
  password: ENV['DB_PASSWORD'],
  database: ENV['DB_NAME']
)

# ポート番も環境変数から呼び出し
server = WEBrick::HTTPServer.new(Port: ENV['PORT'])

# ログを出す部分、多分ここはそんなに考えなくていい
server.config[:AccessLog] = [
  [ $stderr, WEBrick::AccessLog::COMMON_LOG_FORMAT ],
  [ $stderr, WEBrick::AccessLog::COMBINED_LOG_FORMAT ]
]

# API
server.mount_proc '/episodes' do |_req, res|
  # クエリを発行してデータベースからデータを取り出す
  result = client.query('SELECT * FROM episodes')

  # 取り出したデータを加工
  data = result.map do |row|
    { id: row['episode_id'], title: row['episode_title'], detaile: row['episode_detail'],
    release_date: row['release_date'] }
  end

  #  HTTPのbodyに加工したデータをJSON形式にして返す
  res.body = data.to_json
  # 送りつけるデータの形式を宣言しておく
  res['Content-Type'] = 'application/json'

  # フロントサーバーからのアクセスを許可するところ　CORSエラーが出るぞ
  res['Access-Control-Allow-Origin'] = ENV['CLIENT_SERVER']
end

# シャットダウンに必要な記述
trap('INT') { server.shutdown }

server.start
