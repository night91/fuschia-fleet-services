module Recruit
  class RecruitingMailingController < ApplicationController
    def new
      @mailing_list = Object.new
    end
  end
end
