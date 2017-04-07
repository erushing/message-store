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

    unless @options[:assignment].blank?
      this_assignment = @options[:assignment].first
      assignment_hash = {
        'user_id' => this_assignment.user_id,
        'comment' => this_assignment.comment,
        'completed' => this_assignment.completed,
        'created_at' => this_assignment.created_at
      }
      json_hash['assignment'] = assignment_hash
    end

    unless @options[:attachments].blank?
      attachments = []
      @options[:attachments].each do |attachment|
        attachment_hash = {
          'attachment_type' => attachment.attachment_type,
          'url' => attachment.url,
          'preview_url' => attachment.preview_url
        }
        attachments.push attachment_hash
      end
      json_hash['attachments'] = attachments
    end

    unless @options[:labels].blank?
      json_hash['labels'] = @options[:labels].map(&:label)
    end

    json_hash
  end

  def self.from_array(messages, options={})
    messages.collect do |message|
      options[:activities] = message.activities
      options[:assignment] = [message.assignment]
      options[:attachments] = message.attachments
      options[:labels] = message.labels
      new(message, options).as_json
    end.compact
  end

  def self.from_array_optimized(messages, options={})
    msg_ids = messages.map(&:id)
    activities = build_metadata_hash(Activity.where(:message_id => msg_ids).to_a)
    assignments = build_metadata_hash(Assignment.where(:message_id => msg_ids).to_a)
    attachments = build_metadata_hash(Attachment.where(:message_id => msg_ids).to_a)
    labels = build_metadata_hash(Label.where(:message_id => msg_ids).to_a)
    messages.collect do |message|
      options[:activities] = activities[message.id]
      options[:assignment] = assignments[message.id]
      options[:attachments] = attachments[message.id]
      options[:labels] = labels[message.id]
      new(message, options).as_json
    end.compact
  end

  def self.build_metadata_hash(input)
    output = {}
    input.each do |i|
      if output[i.message_id].nil?
        output[i.message_id] = [i]
      else
        output[i.message_id] << i
      end
    end

    output
  end

end
