class TopicsController < ApplicationController
  before_action :set_topic, only: [:show, :update, :destroy]

  def index 
    @topics = Topic.all 
    json_response(@topics)
  end

  def show 
    json_response(@topic)
  end

  def create 
    @topic = Topic.create!(topic_params)
    json_response(@topic, :created)
  end

  def update
    @topic.update!(topic_params)
    head :no_content
  end

  def destroy
    @topic.destroy
    head :no_content
  end

  private 

  def set_topic 
    @topic = Topic.find(params[:id])
  end

  def topic_params 
    params.permit(:name)
  end
end
