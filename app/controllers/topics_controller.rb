class TopicsController < ApplicationController
  before_filter :get_extract_topic
    before_filter :authenticate_user!


  def get_extract_topic
    @extract_topic =  ExtractTopic.find(params[:extract_topic_id])
  end

  # GET /topics
  def index
        @topics  = Topic.where( extract_topic_id: @extract_topic[:id]).paginate(:page => params[:page])
        @collection = Collection.find(@topics[0][:collection_id])
  end

  def show
    @topic = Topic.find(params[:id])
    @collection = Collection.find(@topic[:collection_id])
    @docs = eval(@topic[:docs])
    @doc_scores = eval(@topic[:doc_vals])
    @doc_scores = @doc_scores[0..49]
    @docs = @docs[0..49]
    @doc_dict = Hash.new
    @docs.each do |d |
          doc_name = TopicDocNames.find(d)
          doc_name = doc_name[:name]
          doc_name = doc_name.split(".")
          @doc_dict[d] =   doc_name[0]
    end
  end



end
