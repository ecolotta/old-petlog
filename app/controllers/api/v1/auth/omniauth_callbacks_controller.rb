class Api::V1::Auth::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  
  def line
    @omniauth = request.env['omniauth.auth']
    @user = User.where(provider: @omniauth['provider'], uid: @omniauth['uid']).first
    if @user
      @user.update!(tokens: @omniauth['credentials'])
    else
      @user = User.create!(
                name: @omniauth['info']['name'],
                provider: @omniauth['provider'],
                uid: @omniauth['uid'],
                password: Devise.friendly_token[0, 20],
                email: Faker::Internet.email)
    end
    
    sign_in(@user)
    redirect_to '/redirect' #ログインとルート分けを行う
  end

  # キャンセルした時にrootに遷移
  def failure
    set_flash_message! :alert, :failure, kind: OmniAuth::Utils.camelize(failed_strategy.name), reason: failure_message
    redirect_to root_path
  end
end
