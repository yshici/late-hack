class DelayInfoMailer < ApplicationMailer
    mail(to: @schedule.user.email, subject: '遅刻しても焦らないで')
end
