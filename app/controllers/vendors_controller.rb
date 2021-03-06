class VendorsController < ApplicationController
  layout 'orders'
  before_action :require_login
       # before_action :set_vendor, only: [:show, :edit, :update, :destroy]

  def index
    @vendors = Vendor.all.order('vendor_name ASC')
  end

  def new
    @vendor = Vendor.new
  end
  
  def create
    @vendor = Vendor.new(vendor_params)
    
    @vendor.save

    if @vendor.save
      redirect_to vendors_path, notice: "Successfully created"
    else
      render 'new'
    end
  end

  def edit
    @vendor = Vendor.find(params[:id])
  end

  def update
    @vendor = Vendor.find(params[:id])
    @vendor.update(vendor_params)

    flash.notice = "Vendor '#{@vendor.vendor_name}' updated!"

    redirect_to vendors_path
  end

  def destroy
      @vendor = Vendor.find(params[:id])
      @vendor.destroy

      flash.notice = "Vendor'#{@vendor.vendor_name} Deleted!"
      
      redirect_to vendors_path
  end

  private

  def vendor_params
    params.require(:vendor).permit(:vendor_name)
  end

  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in to access this section."
      redirect_to login_path
    end
  end
end

