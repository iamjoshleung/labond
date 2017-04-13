class PostsController < ApplicationController
  before_action :set_post, only: [:show, :update, :destroy]

  def index 
    @posts = Post.includes(:topics).all 

    json_response(@posts.to_json(:include => [:topics]))
  end

  def show 
    json_response(@post.to_json(:include => [:topics]))
  end

  def create 
    @post = Post.create!(post_params)
    json_response(@post.to_json(:include => [:topics]), :created)
  end

  def update 
    @post.update!(post_params)
    head :no_content
  end

  def destroy 
    @post.destroy
    head :no_content
  end

  private 

  def set_post 
    @post = Post.find(params[:id])
  end

  def post_params 
    params.permit(:title, 
                  :body, 
                  topics_attributes: [:id, :name, :_destroy])
  end
end
