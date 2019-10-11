class UserMailer < ApplicationMailer
  def account_activation user
    @user = user

    mail to: user.email, subject: t("mailers.user_mailer.active_subject")
  end
end
