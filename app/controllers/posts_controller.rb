class PostsController < ApplicationController
 before_action :authenticate_user
 before_action :ensure_correct_user,{only:[:edit, :update, :destroy]}
 
  def index
    @posts = Post.all.order(created_at: :desc)
  end
  
  
  def show
    @post = Post.find(params[:id])
    #@user = User.find_by(id: @post.user_id)
    @user = @post.user
    @likes_count = Like.where(post_id: @post.id).count
  end
  
  
  def new
   
    @post = Post.new(content:params[:content])
  end
  
  
  def create
   @post = Post.new(
   content: params[:content],
   user_id: @current_user.id
   )
    if @post.save
      
      flash[:notice] = "投稿を作成しました"
      redirect_to posts_path
    else
      render "new"
    end
  end
  
  
  def edit
    @post = Post.find(params[:id])
  end
  
  
  def update
    @post = Post.find(params[:id])
    @post.content = params[:content]
  if @post.save
      flash[:notice] = "投稿を編集しました"
      redirect_to posts_path
  else
      render "edit"
  end
end
  
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to posts_path
  end
  
  def ensure_correct_user
  @post = Post.find(params[:id])
   if @post.user_id != @current_user.id
    flash[:notice] = "権限がありません"
    redirect_to posts_path
   end
  end
end