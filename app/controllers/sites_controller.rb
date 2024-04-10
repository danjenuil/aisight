class SitesController < ApplicationController
  skip_before_action :authenticate_user!
  def homepage
    if user_signed_in?
      redirect_to images_path
    end
  end
end
