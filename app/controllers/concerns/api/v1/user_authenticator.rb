module Api::V1::UserAuthenticator
  extend ActiveSupport::Concern

  # リクエストの認証ヘッダーから渡ってくるJWTトークンをもとに 認証されたユーザを返す
  def current_user
    return @current_user if @current_user

    token = request.headers['Authorization'].split(' ').last
    decoded_token = User.decode(token)
    @current_user = User.find_by(id: decoded_token['user_id'])
  end

  # 未ログイン状態のときにunauthorized http statusをクライアントに返す
  def authenticate!
    return if current_user

    render json: { status: :error, message: :unauthorized }, status: :unauthorized
  end

end
