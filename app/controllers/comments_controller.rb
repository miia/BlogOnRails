class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end


  #This method has been modified in order to allow inserting new comments to a Post directly, using the form in the Post's view:
  # POST /comments
  # POST /comments.json
  def create
    @post = Post.find(params[:post_id])   #retrieve the specific post that we want to add a comment to; remember the params[:post_id] hash variable has already been set before getting into this Controller, as part of the request->route->dispatch cycle.
    @comment = @post.comments.create(comment_params) #so the specific comment will be created UNDER the retrieved post (this is possible because of the ASSOCIATIONS we have defined before: a post has_many comments, therefore in our webapp's Model a list of Comment objects (or some other container) is part of each Post object)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @post, notice: 'Comment was successfully created.' }  
        format.json { render :show, status: :created, location: @comment }
        format.js  #ADDED in order to make the server return some JS code; this will come into play when the server receives an Asynchronous HTTP Request (using AJAX), which asks for JS code in return.
                   #WARNING: this line above ASSUMES there's a file create.js.erb which should be executed when this request is triggered. need to create that file! (see create.js.erb)
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:post_id, :body)
    end
end
