module Recruit
  class RecruitingMailingController < ApplicationController
    include RecruitingMailingHelper

    def new
    end

    def create
      file = mailing_list_params[:file]
      @new_names_list = process_mailing_list_upload(file)
    end

    private

    def mailing_list_params
      params.require(:mailing_list).permit(:file)
    end
  end
end
