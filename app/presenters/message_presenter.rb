class MessagePresenter

  def initialize(message, options = {})
    @message = message
    @options = options
  end

  def as_json(*)
    json_hash = {
      'id' => @message.id,
      'type' => @message.message_type,
      'posted_at' => @message.posted_at.iso8601,
      'read' => @message.read,
      'status' => @message.status,
      'title' => @message.title,
      'description' => @message.description,
      'body' => @message.body,
      'likes_count' => @message.likes_count,
      'replies_count' => @message.replies_count,
      'shares_count' => @message.shares_count,
      'channel_id' => @message.channel_id,
      'account_id' => @message.account_id,
      'author' => @message.author.presence
    }

    json_hash
  end

  def self.from_array(messages, options={})
    messages.collect do |message|
      new(message, options).as_json
    end.compact
  end


end
