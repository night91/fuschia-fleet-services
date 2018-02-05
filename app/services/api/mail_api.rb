module Api
  module MailApi
    def character_mail_list(character_id)
      get("#{@endpoint}/characters/#{character_id}/mail/")
    end

    def character_mail(character_id, mail_id)
      get("#{@endpoint}/characters/#{character_id}/mail/#{mail_id}/")
    end

    def send_simple_mail(character_id, destination_character_id, subject, body)
      params = {
        recipients: [
          { recipient_type: 'character', recipient_id: destination_character_id }
        ],
        subject: subject,
        body: body
      }
      post("#{@endpoint}/characters/#{character_id}/mail/", params)
    end
  end
end