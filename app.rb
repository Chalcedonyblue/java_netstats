require 'sinatra'
require 'sinatra/json'

get '/' do
  # netstat で ESTABLISHED なコネクションを取得
  lines = (`netstat -an -p tcp | grep ESTABLISHED`).split("\n")

  # ヘッダを削除
  lines.shift(2)

  # ポート番号以下を削除
  lines = lines.collect{|x| x.split(/\s+/) }

  # ローカルホスト同士の通信を削除（適当）
  list = lines.collect{|x| x[4].sub(/\.\d+$/,'') }.select{|x| x != "127.0.0.1" }

  # 重複を取り除き、重複数をカウント
  data = list.inject({}){|c,x| c[x] ||=0 ; c[x]+=1; c  }

  # json で返す
  json(data)
end
