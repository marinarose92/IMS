class LibrariesController < ApplicationController
    layout 'orders'
    before_action :require_login
          #before_action :set_library, only: [:show, :edit, :update, :destroy]
      
    def index
    @libraries = Library.all.order('name ASC')
    end

    def show
    end

    def new
        @library = Library.new
    end

    def edit
        @library = Library.find(params[:id])
    end
    
    def create
        @library = Library.new(library_params)
        
        @library.save

        if @library.save
            redirect_to libraries_path, notice: "Successfully created"
        else
            render 'new'
        end
        end

    def update
        @library = Library.find(params[:id])
        @library.update(library_params)

        flash.notice = "library '#{@library.name}' updated!"

        redirect_to libraries_path
    end

    def destroy
        @library = Library.find(params[:id])
        @library.destroy

        flash.notice = "Library '#{@library.name}' Deleted!"
        
        redirect_to libraries_path
    end

    private

    # Never trust parameters from the scary internet, only allow the white list through.
    def library_params
        params.require(:library).permit(:name, :df_lic)
    end
    
    def require_login
        unless logged_in?
          flash[:error] = "You must be logged in to access this section."
          redirect_to login_path
        end
      end
end

