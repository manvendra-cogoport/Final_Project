class UsersController < ApplicationController
    before_action :authorize_request, except: :create
    # before_action :authenticate, except: :create
    before_action :find_user, except: %i[create index]

  # GET /users
  def index
    @users = User.all
    render json: @users, status: :ok
  end

  # GET /users/{username}
  def show
    render json: @user, status: :ok
  end

  # POST /users
  def create
    # @user = User.new(user_params)
    # if @user.save
    #   render json: @user, status: :created
    # else
    #   render json: { errors: @user.errors.full_messages },
    #          status: :unprocessable_entity
    # end
    @user = User.create(user_params)
    render json: @user
  end

  # PUT /users/{username}
  def update
      # unless @user.update(user_params)
      #   render json: { errors: @user.errors.full_messages },
      #          status: :unprocessable_entity
      # end
      if(@current_user.id == @user.id)
        @current_user.desc = params[:desc] || @current_user.desc
        @current_user.profile_image = params[:profile_image] || @current_user.profile_image
        @current_user.save
        render json: @current_user
      else
       render text: 'access denied'
      end
  end

  # DELETE /users/{username}
  def destroy
      @current_user.destroy
  end

  private

  def find_user
    @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'User not found' }, status: :not_found
  end

  def user_params
    params.permit(:username, :email, :password)
  end

  # def authenticate
  #   if(@current_user.id != @user.id)
  #     render text: 'Access Denied'
  #   end
  # end
end
