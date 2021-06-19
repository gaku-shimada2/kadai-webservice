class ProductsController < ApplicationController
  def show
    @product = Product.find(params[:id])
    @purchase = Purchase.new
    session[:purchase_product_id]  = @product.id
  end
end
