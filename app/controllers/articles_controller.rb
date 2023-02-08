class ArticlesController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :authorize_request, except: :index
    before_action :find_article, except: :create
    before_action :authenticate , except: :create

    def index
        a=  Article.limit(10).offset(0)
        render json: a 
    end
    
    def create 
        # user =User.find(@current_user.id)
        a= @current_user.articles.create(user_params)
        cat_arr=params[:categories]
        cat_arr.each{
            |cat_arr|
            Journal.create(article_id: a.id, category_id: cat_arr)
        }
        render json: a
    end

    def read_all 
        lim=10
        page_no=(params[:page]).to_i
        
        a= Article.limit(lim).offset(lim*(page_no-1))
        render json: a
    end

    def read
        # a = Article.find(params[:id])
        render json: @article
    end
    
    def update
        # a = Article.find(params[:id])
        @article.article_title = params[:article_title] || @article.article_title
        @article.article_text = params[:article_text] || @article.article_text
        @article.article_image = params[:article_image] || @article.article_image
        @article.article_date = params[:article_date] || @article.article_date

        @article.save
        render json: @article
    end

    def delete 
        # a=Article.find(params[:id])
        
        j=Journal.where(article_id: @article.id)
        j.each{
            |j|
            j.delete
        }
        @article.delete
    end

    def byusername 
        u= User.find_by(username: params[:username])
        a= Article.where(user_id: u.id)
        render json: a
    end

    def partialsearch
        arr=[]
        a= Article.where("article_title like ?", "%#{params[:search_text]}%")
        b = Article.where("article_text like ?", "%#{params[:search_text]}%")
        arr.push(a)
        arr.push(b)
        render json: arr
    end

    private
    def user_params
        params.permit(:user_id, :article_title, :article_text,
              :article_date)
    end

    def authenticate
        if(@current_user.id != @article.user_id)
            raise "Access Denied"
        end
    end

    def find_article
        @article = Article.find(params[:id])
        rescue ActiveRecord::RecordNotFound
          render json: { errors: 'User not found' }, status: :not_found
    end

end
