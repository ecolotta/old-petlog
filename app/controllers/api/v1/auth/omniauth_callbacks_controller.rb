class Api::V1::Auth::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def line
    @omniauth = request.env['omniauth.auth']
    @user = User.where(provider: @omniauth['provider'], uid: @omniauth['uid']).first
    if @user && @user.dog.present?
      @user.update!(tokens: @omniauth['credentials'])
      redirect_to root_path, flash: { token: @user.create_tokens }
    elsif @user && @user.dog.nil?
      redirect_to '/register_dog', flash: { token: @user.create_tokens }
    else
      @user = User.create!(name: @omniauth['info']['name'], provider: @omniauth['provider'], uid: @omniauth['uid'])
      redirect_to '/register_dog', flash: { token: @user.create_tokens }
    end
  end

  # キャンセルした時にrootに遷移
  def failure
    set_flash_message! :alert, :failure, kind: OmniAuth::Utils.camelize(failed_strategy.name), reason: failure_message
    redirect_to root_path
  end
end
