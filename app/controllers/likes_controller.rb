class LikesController < ApplicationController
    before_action :authorize_request

    # def like 
    #     a= Like.where(article_id: params[:article_id])
        
    #     if a.empty?() 
    #         raise "article does not exist"
    #     else 
    #         user_exist=false

    #         a.each{
    #             |a| 
    #             if (a.user_id == @current_user.id)
    #             article=Article.find(params[:article_id])
    #             article.no_of_likes = article.no_of_likes -1
    #             li=Like.find(params[:article_id])
                
    #             article.save
    #             end
    #         }
    #         if user_exist
    #             article=Article.find(params[:article_id])
    #             article.no_of_likes = article.no_of_likes -1
    #             like.delete
    #             like.save
    #             article.save
    #         else 
    #             article= Article.find(params[:article_id])
    #             article.no_of_likes= article.no_of_likes +1 
    #             Like.create(user_id: @current_user.id, article_id: params[:article_id])
    #             article.save
    #         end
             
    #     end
    # end
    
    def like
        article = Article.find(parmas[:id])
        like = article.likes.find_by(user_id: @current_user.id)
        if(like?)
            like.destroy
            article.no_of_likes = article.no_of_likes -1;
        else
            article.likes.create(user_id: @current_user.id)
            article.no_of_likes = article.no_of_likes + 1;
        end
        article.save
        render json: article
    end

    def mostliked
        l= Article.order(no_of_likes: :desc)
        render json: l
    end

    
end

