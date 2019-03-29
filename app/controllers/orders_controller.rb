class OrdersController < ApplicationController
  require 'date'
    #before_action :set_order, only: [:show, :edit, :update, :destroy]

    def index
      @orders = Order.all
      @vendors = Vendor.all
      @libraries = Library.all
      @products = Product.all
    end
  
    def show
    end

    def new
      @order = Order.new
      @vendors = Vendor.all
      @libraries = Library.all
      @products = Product.all
    end

    def edit
      @order = Order.find(params[:id])
      @vendors = Vendor.all
      @libraries = Library.all
      @products = Product.all
    end
    
    def create
      @order = Order.new(order_params)
    
      @order.save
  
      if @order.save
      redirect_to orders_path, notice: "Successfully created"
      else
      render 'new'
      end
    end

    def update
      @order = Order.find(params[:id])
      @order.update(order_params)
  
      flash.notice = "Order '#{@order.product}' updated!"
  
      redirect_to orders_path
    end

    def destroy
      @order = Order.find(params[:id])
      @order.destroy

      flash.notice = "Order '#{@order.product}' Deleted!"
      
      redirect_to orders_path
    end

    def datepicker_input form, field
      content_tag :td, :data => {:provide => 'datepicker', 'date-format' => 'yyyy-mm-dd', 'date-autoclose' => 'true'} do
        form.text_field field, class: 'form-control', placeholder: 'YYYY-MM-DD'
      end
    end
  
    private
  
      # Never trust parameters from the scary internet, only allow the white list through.
      def order_params
        params.require(:order).permit(:date, :library, :product, :price, :serial_no, :vendor, :po_no )
      end
  end