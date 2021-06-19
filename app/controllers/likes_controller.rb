class LikesController < ApplicationController
   before_action :require_user_logged_in
  def create
    product = Product.find(params[:product_id])
    current_user.like(product)
    flash[:success] = 'お気に入りを追加しました。'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    product = Product.find(params[:product_id])
    current_user.unlike(product)
    flash[:success] = 'お気に入りを解除しました。'
    redirect_back(fallback_location: root_path)
  end
end
