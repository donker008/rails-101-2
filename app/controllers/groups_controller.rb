class GroupsController < ApplicationController
  def index
    @groups = Group.all
  end

  def show

  end

  def edit
  end

  def new
    @group = Group.new
  end

  def create
  end

  def update
  end

  def destroy

  end

end
