module Recruit
  class RecruitingMailingController < ApplicationController
    include RecruitingMailingHelper

    def new
    end

    def create
      file = mailing_list_params[:file]
      new_names = process_mailing_list_upload(file)
      send_data(new_names, filename: 'recruiting_mail_list.txt')
    end

    private

    def mailing_list_params
      params.require(:mailing_list).permit(:file)
    end
  end
end
