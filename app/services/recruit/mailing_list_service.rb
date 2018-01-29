module Recruit
  class MailingListService
    def process_mailing_list_upload(file)
      new_names = []
      file_data =  File.read(file.path)

      file_data.split(',').each do |name|
        name = sanitize_name(name)
        new_names << name if RecruitingMailing.new(name: name).save
      end

      new_names.join(', ')
    end

    private

    def sanitize_name(name)
      name.split.join(' ')
    end
  end
end
