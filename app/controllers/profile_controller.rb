class ProfileController < ApplicationController
  def index
    @profile = User.find_by_username params[:username]
  end
end
