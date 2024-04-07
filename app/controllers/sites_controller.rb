class SitesController < ApplicationController
  def homepage
    if user_signed_in?
      redirect_to images_path
    end
  end
end
