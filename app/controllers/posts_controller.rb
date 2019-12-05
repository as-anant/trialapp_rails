class PostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = '投稿しました。'
      redirect_to root_url
    else
      @posts = current_user.feed_posts.order(id: :desc).page(params[:page])
      flash.now[:danger] = '投稿に失敗しました。'
      render 'toppages/index'
    end
  end

  def destroy
    @post.destroy
    flash[:success] = '投稿を削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  def search
    if params[:content].present?
      @posts = Post.where('content LIKE ?', "%#{params[:content]}%").order(actioned_at: :desc).page(params[:page])
    else
      @posts = Post.none.page(params[:page])
    end
    @count_searched = @posts.count
  end
  
  private

  def post_params
    params.require(:post).permit(:content, :img, :actioned_at)
  end
  
  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    unless @post
      redirect_to root_url
    end
  end
  
end
