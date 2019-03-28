class LibrariesController < ApplicationController
          #before_action :set_library, only: [:show, :edit, :update, :destroy]
      
    def index
    @libraries = library.all
    end

    def show
    end

    def new
    @library = library.new
    end

    def edit
    @library = library.find(params[:id])
    end
    
    def create
    @library = library.new(library_params)
    
    @library.save

    if @library.save
    redirect_to libraries_path, notice: "Successfully created"
    else
    render 'new'
    end
    end

    def update
    @library = library.find(params[:id])
    @library.update(library_params)

    flash.notice = "library '#{@library.product}' updated!"

    redirect_to libraries_path
    end

    def destroy
    @library = library.find(params[:id])
    @library.destroy

    flash.notice = "Library '#{@library.product}' Deleted!"
    
    redirect_to librarys_path
    end

    private

    # Never trust parameters from the scary internet, only allow the white list through.
    def library_params
        params.require(:library).permit(:library_name)
    end
end
end
