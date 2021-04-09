class PostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user_posts, only: [:destroy, :edit, :update]
  
  
  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = '喫煙記録を追加しました。'
      redirect_to "/users/#{current_user.id}"
    else
      flash.now[:danger] = '追加できませんでした。'
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    if @post.update(post_params)
      flash[:success] = '正常に更新されました'
      redirect_to "/users/#{current_user.id}"
    else
      flash.now[:danger] = '更新できませんでした'
      render :edit
    end
  end

  def destroy
    @post.destroy
    flash[:success] = '削除しました。'
    redirect_back(fallback_location: "/users/#{current_user.id}")
  end
  
  
  private
  
  def post_params
    params.require(:post).permit(:date, :number)
  end
  
  def correct_user_posts
    @post = current_user.posts.find_by(id: params[:id])
    unless @post
      redirect_to "/users/#{current_user.id}"
    end
  end
  
end
