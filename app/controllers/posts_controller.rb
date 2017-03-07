class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :update, :destory]

  def index
    @group = Group.find(params[:group_id])
    @posts = @group.posts.recent.paginate(:page => params[:page], :per_page => 5 )
  end

  def show
    @group = Group.find(params[:group_id])
    @posts = @group.posts.recent.paginate(:page => params[:page], :per_page => 5 )
  end

  def new
    @group = Group.find(params[:group_id])
    @post = Post.new
  end

  def edit
    @group = Group.find(params[:group_id])
    @post = Post.find(params[:id])
    if @post.user != current_user
      flash[:warning] = "你不能编辑别人的文章"
    end
  end

  def update
    @group = Group.find(params[:group_id])
    @post = Post.find(params[:id])
    if @post.user != current_user
      flash[:warning] = "你不能编辑别人的文章"
    else
      if @post.update(post_params)
        flash[:notice] = "修改成功！"
        redirect_to account_posts_path
      else
        flash[:alert] = "修改失败！"
        redirect_to account_posts_path
      end
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.user == current_user
      if @post.delete
        flash[:notice] = "删除成功！"
        redirect_to account_posts_path
      else
      end
    else
      flash[:warning] = "你不能删除别人的文章"
    end
  end

  def create
    @group = Group.find(params[:group_id])
    @post = Post.new(post_params)
    @post.group = @group
    @post.user = current_user
    if @post.save
      redirect_to group_path(@group)
    else
      #flash[:alert] = "post failed!"
      render :new
    end
  end

  def post_params
    params.require(:post).permit(:content)
  end
end
