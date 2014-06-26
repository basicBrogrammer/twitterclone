class PostsController < ApplicationController
  before_action :user_sign_in, only: [:create, :destroy]
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Post Created!"
      redirect_to current_user
    else
      redirect_to current_user
      flash[:failure] = "Post was not created(bang)(bang) "
    end
  end

  def destroy

  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
