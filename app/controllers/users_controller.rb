class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :require_user_logged_in, only: [:edit, :update, :purchases, :likes]
  before_action :require_user_check, only: [:edit, :update, :purchases, :likes]

  def show
    unless logged_in?
      unless session[:create_user_id].to_s  == params[:id]
        flash[:danger] = 'aaaaa。'  
        redirect_to login_url
      end
      else
        require_user_logged_in
        require_user_check
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = '登録が完了しました。'
      session[:create_user_id]  = @user.id
      redirect_to @user
    else
      flash.now[:danger] = '登録に失敗しました。'
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @user.update(user_params)
      flash[:success] = '更新が完了しました。'
      redirect_to @user
    else
      flash.now[:danger] = '更新に失敗しました。'
      render :edit
    end
  end
  
  def purchases
    @purchases = current_user.purchases.all.order(created_at: :desc).page(params[:page])
  end
  
  def likes
    @likes = current_user.likes.all.order(created_at: :desc).page(params[:page])
  end
  
  def usercomplete
    @user = User.find(session[:create_user_id])
  end  
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :postalcode, :prefecture, :address1, :address2, :tel, :password, :password_confirmation)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def require_user_check
    unless current_user.id.to_s == params[:id]
      flash[:danger] = '再ログインが必要です。'  
      redirect_to login_url
    end
  end

end

