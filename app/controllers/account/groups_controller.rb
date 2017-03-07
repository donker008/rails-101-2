class Account::GroupsController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user
      @groups = current_user.participated_groups
    else
      redirect_to groups_path
    end
  end
end
