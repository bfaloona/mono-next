
#
# This file was originally written for Padrino 0.13 by
# Brandon Faloona, then migrated to Sinatra 3.0.5 by
# GPT-3's text-davinci-003 engine, with prompts from Steven Shults. 
# December 2022.
#

require 'sinatra'
require 'bcrypt'

class Account < Sinatra::Base
  enable :sessions

  attr_accessor :password, :password_confirmation

  # Validations
  validates :email, :role, presence: true
  validates :password, presence: true, if: :password_required
  validates :password_confirmation, presence: true, if: :password_required
  validates :password, length: {within: 4..40}, if: :password_required
  validates :password, confirmation: true, if: :password_required
  validates :email, length: {within: 3..100}
  validates :email, uniqueness: {case_sensitive: false}
  validates :email, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i}
  validates :role, format: {with: /[A-Za-z]/}

  # Callbacks
  before :save, if: :password_required do
    encrypt_password
  end

  ##
  # This method is for authentication purpose.
  #
  def self.authenticate(email, password)
    account = where("lower(email) = lower(?)", email).first if email.present?
    account && account.has_password?(password) ? account : nil
  end

  def has_password?(password)
    ::BCrypt::Password.new(crypted_password) == password
  end

  private

  def encrypt_password
    value = ::BCrypt::Password.create(password)
    value = value.force_encoding(Encoding::UTF_8) if value.encoding == Encoding::ASCII_8BIT
    self.crypted_password = value
  end

  def password_required
    crypted_password.blank? || password.present?
  end
end