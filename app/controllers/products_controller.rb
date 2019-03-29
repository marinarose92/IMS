class ProductsController < ApplicationController
        # before_action :set_product, only: [:show, :edit, :update, :destroy]
 
   def index
     @products = Product.all
   end
 
   def new
     @product = Product.new
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
     params.require(:product).permit(:product_name, :price)
   end
end
