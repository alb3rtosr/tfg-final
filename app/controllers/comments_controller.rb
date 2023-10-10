class CommentsController < ApplicationController
        def create
            @comment = Comment.new(comment_params)
            @comment.user = current_user
            respond_to do |format|
              if @comment.save
                Rails.logger.info("*****************************************************************************************\n3 Okay")
                format.html { redirect_to @comment.post, notice: "Comment was successfully created." }
              else
                Rails.logger.info("*****************************************************************************************\n3 NOkay")
                format.html { redirect_to @comment.post, warning: "Comment could not be created."}
              end
            end
        end
        

        def destroy
          @post = Post.find(params[:post_id])
          @comment = @post.comments.find(params[:id])
          @comment.destroy
          redirect_to post_path(@post)
        end
      
        private
      
        def comment_params
            params.require(:comment).permit(:post_id, :content)
        end 
end
