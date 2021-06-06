class Api::V1::Auth::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def line
    @omniauth = request.env['omniauth.auth']
    if @omniauth.present?
      # binding.pry
      @user = User.where(provider: @omniauth['provider'], uid: @omniauth['uid']).first || User.create(name: @omniauth['info']['name'], provider: @omniauth['provider'], uid: @omniauth['uid'])
      @user.update!(token: @omniauth['credentials'])
      json_string = @user.create_tokens
      render json: json_string
    else
      render status: :404
    end
  end

  def failure #キャンセルした時にrootに遷移
    set_flash_message! :alert, :failure, kind: OmniAuth::Utils.camelize(failed_strategy.name), reason: failure_message
    redirect_to root_path
  end
end
