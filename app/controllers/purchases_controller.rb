class PurchasesController < ApplicationController
  before_action :require_user_logged_in
  
  def confirm
    @purchase = Purchase.new(purchase_params)
    @product = Product.find(session[:purchase_product_id] )
    if @purchase.quantity == nil then
      flash.now[:danger]  = '数量を入力してください。'
      render file: "app/views/products/show.html.erb"
    elsif @purchase.quantity < 0 && quantity > 4 then
      flash.now[:danger]  = '数量を正しく入力してください。'
      render file: "app/views/products/show.html.erb"
    else
      
    session[:purchase_quantity]  = @purchase.quantity
    end
  end

  def create
    @purchase = current_user.purchases.build(product_id: session[:purchase_product_id], quantity: session[:purchase_quantity], payment_method: purchase_params[:payment_method])
    session[:payment_method] = @purchase.payment_method
    if @purchase.save
      flash[:success] = '購入が完了しました。'
      redirect_to complete_path
    else
      flash.now[:danger] = '購入が失敗しました。'
      redirect_to complete_path
    end
  end
  
  def complete
    @product = Product.find(session[:purchase_product_id] )
  end
  
  private
  def purchase_params
    params.require(:purchase).permit(:quantity, :payment_method)
  end
  
end
