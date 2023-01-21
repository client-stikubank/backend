# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: ENV['MAILER_EMAIL']
  default template_path: 'devise/mailer'
  layout 'mailer'

  def send_confirmation(user_id, generated_password)
    @user = User.find(user_id)
    @generated_password = generated_password

    mail(to: @user.email, subject: 'Registration Success')
  end

  def reset_password_instructions(user_id)
    @user = User.find(user_id)

    create_reset_password_token(@user)

    mail(to: @user.email, subject: 'Youthcamp: Reset Code - Lupa Kata Sandi')
  end

  private

  def create_reset_password_token(user)
    # raw, hashed = Devise.token_generator.generate(User, :reset_password_token)
    # @token      = raw

    # user.reset_password_token   = hashed
    user.reset_password_sent_at = Time.zone.now
    user.reset_code = SecureRandom.alphanumeric(6).upcase
    user.save
  end
end
