class OrdersController < ApplicationController
  layout 'orders'
  require 'date'
  before_action :require_login
    #before_action :set_order, only: [:show, :edit, :update, :destroy]


    def index
      @orders = Order.all
      if params[:search]
        @orders = Order.search(params[:search]).order("created_at DESC")
      else
        @orders = Order.all.order('po_no DESC')
      end
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
      @vendor = Vendor.all
    
      @order.save
  
      if @order.save!
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
  
    private
  
      # Never trust parameters from the scary internet, only allow the white list through.
      def order_params
        params.require(:order).permit(:date, :library_id, :product_name, :product_id, :price, :serial_no, :vendor_id, :po_no, :search, :search)
      end
  end

    def require_login
    unless logged_in?
      flash[:error] = "You must be logged in to access this section."
      redirect_to login_path
    end
  end