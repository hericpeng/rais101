class Account::PostsController < ApplicationController
  before_action :authenticate_user!, only:[:edit, :update]

  def index
    @posts = current_user.posts
  end
  def edit
      @group = Group.find(params[:group_id])
      @post = Post.find(params[:id])
      if current_user != @post.user
        redirect_to account_posts_path, alert:"You have no permission."
      end
  end

  def update
      @group = Group.find(params[:group_id])
      @post = Post.find(params[:id])

      if @post.update(post_params)
          redirect_to account_posts_path, notice: "Post Update Success"
      else
          render :edit
      end
   end

   def destroy
     @group = Group.find(params[:group_id])
     @post = Post.find(params[:id])
     if @post.destroy
       redirect_to account_posts_path, alert: "Post Deleted"
     end
   end

   private

   def post_params
       params.require(:post).permit(:content)
   end
end
