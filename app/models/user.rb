class User < ApplicationRecord
  before_save :downcase_email

  validates :name,
    presence: true,
    length: {maximum: Settings.user.names.max_length}
  validates :email,
    presence: true,
    length: {maximum: Settings.user.email.max_length},
    format: {with: Settings.user.email.regex_valid},
    uniqueness: {case_sensitive: false}
  validates :password,
    presence: true,
    length: {minimum: Settings.user.password.min_length}

  has_secure_password

  private

  def downcase_email
    email.downcase!
  end
end