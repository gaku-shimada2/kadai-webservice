class ToppagesController < ApplicationController
  def index
    @products = Product.all
  end
end
