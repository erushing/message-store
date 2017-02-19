namespace :messages do
  desc "Set up an Account, Channel and Messages"
  task :create => :environment do
    account = Account.first_or_create(
      :name => "Test Account",
      :status => "live"
    )

    channel = Channel.first_or_create(
      :name => "Test Channel",
      :account_id => account.id,
      :channel_type => "FacebookPage",
      :status => "enabled"
    )

    100.times do |i|
      Message.create(
        :message_type => 'FacebookPost',
        :account_id => account.id,
        :channel_id => channel.id,
        :external_id => "12345678_#{format('%08d', i)}",
        :author => "Author#{i}",
        :author_id => "1234#{i}",
        :title => "Hello #{i}",
        :description => "This is a description",
        :body => "HEY MAN #{i}, this is the body right here.  #body",
        :posted_at => Time.now
      )
    end
  end

  desc "Create a large number of messages"
  task :create_bigly => :environment do
    messages = []
    ActiveRecord::Base.connection.execute("TRUNCATE messages")
    1000000.times do |i|
      messages << Message.new(
        :message_type => %w(FacebookPost TwitterStatus InstagramPost LinkedinPost TumblrPost Snap).sample,
        :account_id => 1,
        :channel_id => [1,2,3,4,5,6,7,8,9,10].sample,
        :external_id => "12345678_#{format('%08d', i)}",
        :author => "Author#{i%100}",
        :author_id => "1234#{i%100}",
        :title => ["Hello #{i}", "Title #{i}", "Hey #{i}"].sample,
        :description => "This is a description",
        :body => ["HEY MAN #{i}, this is the body right here.  #body",
                  "This thing is getting pretty bigly #{i}",
                  "This is a message body #{i} #messagebody",
                  "I have tiny hands #{i} #trumphands",
        ].sample,
        :posted_at => Time.now
      )

      if ((i+1) % 10000 == 0)  ### i starts at 0
        Message.import messages
        messages = []
        puts "Created #{i+1} Messages"
      end
    end
  end
end
