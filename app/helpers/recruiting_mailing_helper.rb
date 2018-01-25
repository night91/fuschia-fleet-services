module RecruitingMailingHelper
  def process_mailing_list_upload(file)
    new_names = []
    file_data =  File.read(file.path)

    file_data.split(',').each do |name|
      new_names << name if RecruitingMailing.new(name: name).save
    end

    new_names
  end
end
