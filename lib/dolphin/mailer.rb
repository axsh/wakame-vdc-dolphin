# -*- coding: utf-8 -*-

require 'action_mailer'
require 'mail-iso-2022-jp'

module Dolphin
  class Mailer < ActionMailer::Base
    ActionMailer::Base.raise_delivery_errors = true
    case Dolphin.settings['mail']['type']
      when 'file'
        ActionMailer::Base.delivery_method = :file
        ActionMailer::Base.file_settings = {
          :location => '/var/tmp'
        }
      when 'tls-mail'
        ActionMailer::Base.delivery_method = :smtp
        ActionMailer::Base.smtp_settings = {
          :address => Dolphin.settings['mail']['host'],
          :port => Dolphin.settings['mail']['port'],
          :user_name => Dolphin.settings['mail']['user_name'],
          :password => Dolphin.settings['mail']['password'],
          :authentication => :plain,
          :enable_starttls_auto => true
        }
      when 'mail'
        ActionMailer::Base.delivery_method = :smtp
        ActionMailer::Base.smtp_settings = {
          :address => Dolphin.settings['mail']['host'],
          :port => Dolphin.settings['mail']['port'],
        }
    end

    default :charset => 'ISO-2022-JP'


    #
    # ==== Examples
    #
    #   read_iso2022_jp_mail('/var/tmp/test@example.com')
    #
    def self.read_iso2022_jp_mail(path, encoding_type='UTF-8')
      data = File.open(path, 'rb').read
      ec = Encoding::Converter.new("ISO-2022-JP", encoding_type)
      converted_data = ec.convert(data)
      data = converted_data.split("\r\n\r\n")
      header = data[0].split("\r\n")
      body = data[1]

      h = Hash.new
      h[:date] = header[0]
      h[:from] = header[1]
      h[:to] = header[2]
      h[:message_id]  = header[3]
      h[:subject] = header[4]
      h[:mime_version] = header[5]
      h[:event_id] = header[9]
      h.map{|k,v| h[k] = v.split(':')[1].strip}

      h[:body] = body
      h
    end

    def notify(send_params)
      if send_params[:from].blank?
        raise 'Not found from field.'
      end

      fqdn = send_params[:from].split('@')[1]

      m = mail(send_params)
      m.message_id(generate_message_id(send_params[:event_id], fqdn))
      m.deliver
    end

    private

    # Refernced function from https://github.com/mikel/mail/blob/master/lib/mail/fields/message_id_field.rb#L77-L79
    def generate_message_id(event_id, fqdn)
      "<#{event_id}@#{fqdn}>"
    end

  end
end