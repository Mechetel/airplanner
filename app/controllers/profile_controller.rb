class ProfileController < ApplicationController
  def index
    @profile = User.find_by username: params[:username]
  end
end
