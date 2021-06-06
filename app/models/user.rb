# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :validatable,
  devise :omniauthable, omniauth_providers: [:line]

  has_one :dog, dependent: :destroy

  def self.decode(token)
    JWT.decode token, Rails.application.credentials.secret_key_base
  end

  def create_tokens
    payload = { user_id: id }
    issue_token(payload.merge(exp: Time.current.to_i + 1.month))
  end

  private

  def issue_token(payload)
    JWT.encode payload, Rails.application.credentials.secret_key_base
  end
end
