class EnquiryNotifier < ActionMailer::Base
  default from: Rails.configuration.enquiries[:from]

  def received(enquiry)
    @enquiry = enquiry
    mail(to: Rails.configuration.enquiries[:to], subject: Rails.configuration.enquiries[:subject], template_path: 'mailers', template_name: 'enquiry')
  end
end
