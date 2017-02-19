class MessagesController < ApplicationController

  def index
    respond_to do |type|
      type.json do
        render :json => present_many(search)
      end
    end
  end

  private

  def present_many(messages)
    MessagePresenter.from_array(messages)
  end

  def search
    if params[:use_solr]
    elsif params[:use_redis]
    else
      query = Message
      query = query.where(:channel_id => params[:channel_ids].to_a) if params[:channel_ids]
      query = query.where(:account_id => params[:account_id]) if params[:account_id]
      query = query.where(:status => params[:status]) if params[:status]
      query = query.limit(30)
      query = query.offset(params[:offset]) if params[:offset]
      query = params[:order] == 'asc' ? query.order('posted_at') : query.order('posted_at desc')
      query
    end
  end

end
