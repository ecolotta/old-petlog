class LinebotController < ApplicationController
  require 'line/bot'
  require 'net/http'
  require 'json'

  def client
    @client ||= Line::Bot::Client.new do |config|
      config.channel_secret = ENV['LINE_MESSAGING_SECRET']
      config.channel_token = ENV['LINE_MESSAGING_TOKEN']
    end
  end

  def callback; end

  def webhook
    body = request.body.read
    signature = request.env['HTTP_X_LINE_SIGNATURE'] # リクエストがLINEから送られたことを確認するための署名
    unless client.validate_signature(body, signature) # LINEからきたことを検証
      head :bad_request
    end
    events = client.parse_events_from(body) # jsonをインスタンスに変更

    events.each do |event|
      case event
      when Line::Bot::Event::Message
        case event.message['text']
        # when 'アカウント'
        #   line_user_id = event['source']['userId']
        #   create_token = client.create_link_token(line_user_id) # linktoken生成メソッド
        #   link_token = JSON.parse(create_token.body.to_s)['linkToken'] # stringに変換

        #   message = {
        #     type: 'template',
        #     altText: 'Account Link',
        #     template: {
        #       type: 'buttons',
        #       text: 'Account Link',
        #       actions: [{
        #         type: 'uri',
        #         label: 'Account Link',
        #         uri: "https://ae9b048da230.ngrok.io/linebot/?linkToken=#{link_token}"
        #       }]
        #     }
        #   }

        #   client.reply_message(event['replyToken'], message) # linktokenをクエリパラメータに渡したサービスログインフォームを返信

        when 'フレックス' # リッチメニューからお世話登録を選択した時に出る選択肢
          message = {
            "type": 'flex',
            "altText": 'This is a Flex Message',
            "contents": {
              "type": 'bubble',
              "body": {
                "type": 'box',
                "layout": 'vertical',
                "contents": [
                  {
                    "type": 'box',
                    "layout": 'horizontal',
                    "contents": [
                      {
                        "type": 'button',
                        "action": {
                          "type": 'postback',
                          "label": 'ごはん',
                          "data": 'care_type, 1'
                        },
                        "color": '#008000',
                        "style": 'primary'
                      },
                      {
                        "type": 'button',
                        "action": {
                          "type": 'postback',
                          "label": 'おさんぽ',
                          "data": 'care_type, 2'
                        },
                        "color": '#008000',
                        "style": 'primary'
                      }
                    ],
                    "paddingAll": 'sm',
                    "spacing": 'md',
                    "position": 'relative'
                  },
                  {
                    "type": 'box',
                    "layout": 'horizontal',
                    "contents": [
                      {
                        "type": 'button',
                        "action": {
                          "type": 'postback',
                          "label": 'おもちゃ',
                          "data": 'care_type, 3'
                        },
                        "color": '#008000',
                        "style": 'primary'
                      },
                      {
                        "type": 'button',
                        "action": {
                          "type": 'postback',
                          "label": 'グルーミング',
                          "data": 'care_type, 4'
                        },
                        "color": '#008000',
                        "style": 'primary'
                      }
                    ],
                    "paddingAll": 'sm',
                    "spacing": 'md',
                    "position": 'relative'
                  },
                  {
                    "type": 'box',
                    "layout": 'horizontal',
                    "contents": [
                      {
                        "type": 'button',
                        "action": {
                          "type": 'postback',
                          "label": 'おくすり',
                          "data": 'care_type, 5'
                        },
                        "color": '#008000',
                        "style": 'primary'
                      },
                      {
                        "type": 'button',
                        "action": {
                          "type": 'postback',
                          "label": 'おそうじ',
                          "data": 'care_type, 6'
                        },
                        "color": '#008000',
                        "style": 'primary'
                      }
                    ],
                    "paddingAll": 'sm',
                    "spacing": 'md',
                    "position": 'relative'
                  },
                  {
                    "type": 'box',
                    "layout": 'horizontal',
                    "contents": [
                      {
                        "type": 'button',
                        "action": {
                          "type": 'postback',
                          "label": '芸の練習',
                          "data": 'care_type, 7'
                        },
                        "color": '#008000',
                        "style": 'primary'
                      },
                      {
                        "type": 'button',
                        "action": {
                          "type": 'postback',
                          "label": '見つめ合い',
                          "data": 'care_type, 8'
                        },
                        "color": '#008000',
                        "style": 'primary'
                      }
                    ],
                    "paddingAll": 'sm',
                    "spacing": 'md',
                    "position": 'relative'
                  },
                  {
                    "type": 'box',
                    "layout": 'horizontal',
                    "contents": [
                      {
                        "type": 'button',
                        "action": {
                          "type": 'postback',
                          "label": '撫でた',
                          "data": 'care_type, 9'
                        },
                        "color": '#008000',
                        "style": 'primary'
                      },
                      {
                        "type": 'button',
                        "action": {
                          "type": 'postback',
                          "label": 'その他',
                          "data": 'care_type, 10'
                        },
                        "color": '#008000',
                        "style": 'primary'
                      }
                    ],
                    "paddingAll": 'sm',
                    "spacing": 'md',
                    "position": 'relative'
                  }
                ]
              }
            }
          }

          client.reply_message(event['replyToken'], message)
        end

      when Line::Bot::Event::Postback # お世話ボタンが押された時にdog_careに保存する
        
        user = User.find_by(uid: event['source']['userId'])
        dog = user.dog
        if event['postback']['data'].include?('care_type')
          care_type_id = event['postback']['data'].split(',')[1].to_i
          dog.dog_cares.create!(care_type_id: care_type_id)
          message = {
            type: 'text',
            text: 'お世話を登録しました！'
          }
          client.reply_message(event['replyToken'], message)
        end

      # when Line::Bot::Event::AccountLink # アカウント連携
      #   line_user_id = event['source']['type'] == 'user' && event['source']['userId']
      #   nonce = event['link']['result'] == 'ok' && event['link']['nonce']
      #   if line_user_id && nonce
      #     user = User.find_by(id: Rails.cache.read("lineAccountLink:#{nonce}")) # キャッシュに保存しているデータと一致していればuserを返す
      #     user.update!(line_id: line_user_id) # 一致していないことはおかしいので失敗したら例外を返す
      #   end
      end
    end
  end

  # # サービスログインフォーム→アカウント連携用コントローラ作成し移動する
  # def index
  #   @user = User.new
  #   @link_token = params[:linkToken] # クエリパラメータから取得
  # end

  # def create
  #   user = login(params[:email], params[:password])
  #   link_token = params[:link_token] # hiddentagから取得
  #   nonce = SecureRandom.urlsafe_base64
  #   Rails.cache.write("lineAccountLink:#{nonce}", user.id, expires_in: 10.minutes) # nonceをキャッシュに保存
  #   redirect_to "https://access.line.me/dialog/bot/accountLink?linkToken=#{link_token}&nonce=#{nonce}"
  # end
end
