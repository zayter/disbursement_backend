# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch('SMTP_FROM', 'example@email.com')

  layout 'mailer'
end
