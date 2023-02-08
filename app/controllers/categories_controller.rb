class CategoriesController < ApplicationController
    # skip_before_action :verify_authenticity_token
    before_action :authorize_request
    before_action :admin
    def read
        c =Category.all 
        render json: c
    end

    def create 
        c= Category.create(category_name: params[:category_name])
        render json: c 
    end

    def index 
        c= Category.find(params[:id])
        render json: c
    end

    private
    def admin 
        if(@current_user.id !=1)
            raise "Only admin can access this page"
        end
    end
end
