class ApplicationMailer < ActionMailer::Base
  default from: 'preeti@joshsoftware.com'
  layout 'mailer'

  def bill_amount(amount, mail_id)
    @amount = amount
    @mail_id = mail_id
    mail(to: @mail_id, subject: 'Your Bill amount')
  end
end
