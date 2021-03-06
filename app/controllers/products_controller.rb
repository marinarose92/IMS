class ProductsController < ApplicationController
  layout 'orders'
  before_action :require_login
        # before_action :set_product, only: [:show, :edit, :update, :destroy]
 
   def index
    @products = Product.all.order('product_name ASC')
    @vendors = Vendor.all
   end
 
   def new
     @product = Product.new
     @vendors = Vendor.all
   end
   
   def create
     @product = Product.new(product_params)
     
     @product.save
 
     if @product.save
       redirect_to products_path, notice: "Successfully created"
     else
       render 'new'
     end
   end
 
   def edit
     @product = Product.find(params[:id])
     @vendors = Vendor.all
     @orders = Order.all
   end
 
   def update
     @product = Product.find(params[:id])
     @product.update(product_params)
 
     flash.notice = "product '#{@product.product_name}' updated!"
 
     redirect_to products_path
   end
 
   def destroy
       @product = Product.find(params[:id])
       @product.destroy
 
       flash.notice = "Item '#{@product.product_name}' Deleted!"
       
       redirect_to products_path
   end
 
   private
 
   def product_params
     params.require(:product).permit(:product_name, :vendor_id, :price)
   end

   def require_login
    unless logged_in?
      flash[:error] = "You must be logged in to access this section."
      redirect_to login_path
    end
  end
end
