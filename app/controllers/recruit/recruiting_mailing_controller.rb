module Recruit
  class RecruitingMailingController < ApplicationController
    def new
    end

    def create
      new_names = process_mailing_list_upload(mailing_list_params[:file])
      send_data(new_names, filename: 'recruiting_mail_list.txt')
    end

    private

    def process_mailing_list_upload(file)
      MailingListService.new.process_mailing_list_upload(file)
    end

    def mailing_list_params
      params.require(:mailing_list).permit(:file)
    end
  end
end
