class CommentsController < ApplicationController

  before_action :prevent_unauthorized_user_access, except: :index
  before_action :set_variables, only: %i[edit update destroy]

  def index
    @comments = Comment.all
  end

  def create
    @link = Link.find_by(id: params[:link_id])
    @comment = @link.comments.new(user: current_user, body: comment_params[:body])

    if @comment.save
      redirect_to @link, notice: 'Comment created'
    else
      redirect_to @link, notice: 'Comment was not saved. Ensure you have entered a comment'
    end
  end



  def edit
    unless current_user.owns_comment?(@comment)
      redirect_to root_path, notice: 'Not authorized to edit this comment'
    end
  end

  def update
    if @comment.update(comment_params)
      redirect_to @link, notice: 'Comment updated'
    else
      render :edit
    end
  end


  def destroy
    if current_user.owns_comment?(@comment)
      @comment.destroy
      redirect_to @link, notice: 'Comment deleted'
    else
      redirect_to @link, notice: 'Not authorized to delete this comment'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_variables
    @link = Link.find_by(id: params[:link_id])
    @comment = @link.comments.find_by(id: params[:id])
  end
end
