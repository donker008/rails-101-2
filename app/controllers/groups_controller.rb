class GroupsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :update, :destroy, :eidt]
  before_action :find_group_and_permission_check, only: [:update, :destroy, :edit]

  def index
    @groups = Group.all
  end

  def join
    @group = Group.find(params[:id])
    if !current_user.is_member_of?(@group)
      current_user.join!(@group)
      flash[:notice] = "已加入本讨论版成功！"
    else
      flash[:warning] = "你已经是本讨论版成员了！"
    end
    redirect_to group_path(@group)
  end

  def quit
    @group = Group.find(params[:id])
    if current_user.is_member_of?(@group)
      current_user.quit!(@group)
      flash[:notice] = "退出本讨论版！"

    else
      flash[:warning] = "你不是本讨论版成员，你咋退出 XD"
    end
    redirect_to group_path(@group)
  end

  def mygroups
    if current_user
      @groups = current_user.groups
    else
      redirect_to groups_path
    end
  end

  def mygroups
    if current_user
      @posts = current_user.posts
    else
      redirect_to groups_path
    end
  end

  def show
    @group = Group.find(params[:id])
    @posts = @group.posts.recent.paginate(:page => params[:page], :per_page => 5 )
  end

  def edit


  end

  def new
    @group = Group.new
  end

  def create

    @group.user = current_user

    if @group.save
      current_user.join!(@group)
      redirect_to groups_path
    else
      render :new
    end
  end

  def update

    if @group.update(group_params)
      redirect_to group_path(@group),  notice: "update Success"
    else
      render :edit
    end
  end

  def destroy

    @group.destroy
    flash[:alert] = "Group deleted!"
    redirect_to groups_path
  end

  private
  def group_params
    params.require(:group).permit(:title, :description)
  end

  def find_group_and_permission_check
    @group = Group.find(params[:id])
    if @group.user != current_user
      redirect_to root_path, alert: "You have no permission."
    end
  end
end
