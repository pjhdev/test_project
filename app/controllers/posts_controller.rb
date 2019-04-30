class PostsController < ApplicationController
  before_action :set_bulletin
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    if @bulletin.present?
      @posts = @bulletin.posts.paginate(:page => params[:page], :per_page => 15)
    else
      if params[:tag]
        @posts = Post.tagged_with(params[:tag]).paginate(:page => params[:page], :per_page => 15)
      else
        @posts = Post.paginate(:page => params[:page], :per_page => 15)
      end
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = @bulletin.present? ? @bulletin.posts.new : Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = @bulletin.present? ? @bulletin.posts.new(post_params) : Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to (@bulletin.present? ? [@post.bulletin, @post] : @post), notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to (@bulletin.present? ? [@post.bulletin, @post] : @post), notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to (@bulletin.present? ? bulletin_posts_url : posts_url), notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_bulletin
    if params[:bulletin_id].present?
      @bulletin = Bulletin.find(params[:bulletin_id])
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    if @bulletin.present?
      @post = @bulletin.posts.find(params[:id])
    else
      if params[:tag]
        @post = Post.tagged_with(params[:tag])
      else
        @post = Post.find(params[:id])
      end
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params.require(:post).permit(:title, :content, :picture, :picture_cache, :tag_list_fixed)
  end
end
