class ApplicationMailer < ActionMailer::Base
  default from: 'christmaslist@stormsilver.net'
  layout 'email'

  def self.delivering_email message
    if Rails.application.secrets.testing_email
      message.attachments["original_email_addresses.txt"] = {:content => message.to.join("\n")}
      message.to = [Rails.application.secrets.testing_email]
    end
  end
end
