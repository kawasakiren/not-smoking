class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :edit, :followings, :followers]
  before_action :forbid_login_user, only: [:new]
  before_action :correct_user, only: [:edit, :update]
  
  def new
    @user=User.new
  end

  def index
    @users=User.order(id: :desc).page(params[:page]).per(25)
  end
  

  def show
    @user=User.find(params[:id])
    
    unless @user.followers.find_by(id: current_user.id) or @user == current_user
      
      flash[:danger] = 'このユーザをフォローしていないため記録は見れません。'
      redirect_back(fallback_location: users_path)
    end
    counts(@user)
    
    @records = @user.posts.page(params[:page]).per(8)
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end

  def edit
    @user=User.find(params[:id])

    
  end

  def update
    @user = User.find(params[:id])
    
    if current_user.id == @user.id
      if @user.update(user_params)
        flash[:success] = '正常に更新されました'
        redirect_to edit_user_url(@user)
      else
        flash.now[:danger] = '更新できませんでした'
        render :edit
      end
    else
      redirect_to "/users/#{current_user.id}"
    end
    
    
  end
  
  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page])
    counts(@user)
  end
  
  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page])
    counts(@user)
  end
  
  private
  
 
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image_name)
  end
  
  def correct_user
    @user=User.find(params[:id])
    unless current_user.id == @user.id
      redirect_to "/users/#{current_user.id}"
    end
  end
end
