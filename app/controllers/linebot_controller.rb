class LinebotController < ApplicationController
  require 'line/bot'
  require 'net/http'
  require 'json'

  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_MESSAGING_SECRET"]
      config.channel_token = ENV["LINE_MESSAGING_TOKEN"]
    }
  end


  def callback
  end

  def webhook
    body = request.body.read
    signature = request.env['HTTP_X_LINE_SIGNATURE'] #リクエストがLINEから送られたことを確認するための署名
    unless client.validate_signature(body, signature) #LINEからきたことを検証
      head :bad_request
    end
    events = client.parse_events_from(body) #jsonをインスタンスに変更

    events.each { |event|
    case event
    when Line::Bot::Event::Message #アカウント連携のフック※ボタンなどに変更する
      case event.message['text']
      when "アカウント"
        line_user_id = event['source']['userId']
        create_token = client.create_link_token(line_user_id) #linktoken生成メソッド
        link_token = JSON.parse(create_token.body.to_s)["linkToken"] #stringに変換

        message = {
          type: "template",
          altText: "Account Link",
          template: {
              type: "buttons",
              text: "Account Link",
              actions: [{
                  type: "uri",
                  label: "Account Link",
                  uri: "https://ae9b048da230.ngrok.io/linebot/?linkToken=#{link_token}"
              }]
            }
          }

        client.reply_message(event['replyToken'], message) #linktokenをクエリパラメータに渡したサービスログインフォームを返信
      end

    when Line::Bot::Event::AccountLink
      line_user_id = event['source']['type'] == 'user' && event['source']['userId']
      nonce = event['link']['result'] == 'ok' && event['link']['nonce']
      if line_user_id && nonce
        user = User.find_by(id: Rails.cache.read("lineAccountLink:#{nonce}")) #キャッシュに保存しているデータと一致していればuserを返す
        user.update!(line_id: line_user_id) #一致していないことはおかしいので失敗したら例外を返す
      end
    end

  
    }
  end

  def index #サービスログインフォーム
    @user = User.new
    @link_token = params[:linkToken] #クエリパラメータから取得
  end

  def create
    user = login(params[:email],params[:password])
    link_token = params[:link_token] #hiddentagから取得
    nonce = SecureRandom.urlsafe_base64
    Rails.cache.write("lineAccountLink:#{nonce}", user.id, expires_in: 10.minutes) #nonceをキャッシュに保存
    redirect_to "https://access.line.me/dialog/bot/accountLink?linkToken=#{link_token}&nonce=#{nonce}"
  end
end
