class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :user_sign_in, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]

  # GET /users
  # GET /users.json
  def index

    @users = User.order(:name).page params[:page]
  end

  def feed
    Post.from_users_followed_by(current_user)
  end

  # GET /users/1
  # GET /users/1.json
  def show
    current_user
    @post = current_user.posts.build if sign_in?
    @feed_items = current_user.feed.page params[:page]

  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.page(params[:page]).per(15)
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.page params[:page]
    render 'show_follow'
  end

  def home
    redirect_to current_user if !current_user.nil?
    @user = User.new
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
      if @user.save
        sign_in(@user)
        flash[:success] = "Welcome to TiY on Rails! Did I mention its awesome? "
        redirect_to @user
      else
        redirect_to root_url
      end

  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])

    end

  def user_sign_in
    redirect_to signin_url, notice: "Please sign in." unless signed_in?
  end

  #this makes sure the user accessing edit and update are the correct user
  def correct_user
    @user =User.find(params[:id])
    redirect_to (root_url) unless current_user?(@user)
  end
  # Never trust parameters from the scary internet, only allow the white list through.
    # password and password_confirmation must be added to all the input from http
    def user_params
      params.require(:user).permit(:name, :username, :email, :password, :password_confirmation)
    end


end
