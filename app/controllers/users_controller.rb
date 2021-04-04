class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :edit]
  before_action :forbid_login_user, only: [:new]
  
  
  def new
    @user=User.new
  end

  def index
  end

  def show
  end

  def create
    @user=User.new(user_params)
    
    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end

  def edit
  end

  def update
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
