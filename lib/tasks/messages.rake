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

  #### TODO  Convert this into a load task to run while doing JMeter tests
  #### TODO  Do some bulk importing and random updating/querying
  desc "Create a large number of messages"
  task :write_load => :environment do
    messages = []
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

      if ((i+1) % 10000 == 0)  ### i starts at 0, batch import in groups
        Message.import messages
        messages = []
        puts "Created #{i+1} Messages"
      end
    end
  end

  desc "Create CSV file for loading into a database"
  task :create_csv, [:message_count,:filename] => :environment do |t, args|
    require 'csv'
    args.with_defaults(:message_count => 1000,:filename => '/tmp/database_import_messages.csv')
    CSV.open("#{args.filename}", "w") do |csv|
      args.message_count.to_i.times do |i|
        csv << [
          i+1,
          %w(FacebookPost TwitterStatus InstagramPost LinkedinPost TumblrPost).sample,
          1,
          [1,2,3,4,5,6,7,8,9,10].sample,
          "12345678_#{format('%08d', i)}",
          "Author#{i%100}",
          "1234#{i%100}",
          "",
          ["Hello #{i}", "Title #{i}", "Hey #{i}"].sample,
          "This is a description",
          ["HEY MAN #{i}, this is the body right here.  #body",
                    "This thing is getting pretty bigly #{i}",
                    "This is a message body #{i} #messagebody",
                    "I have tiny hands #{i} #trumphands",
          ].sample,
          0,0,0,
          Time.now,
          Time.now,
          Time.now,
          false,
          false,
          'active',
          false,
          false
        ]

        if ((i+1) % 10000 == 0)  ### i starts at 0, batch import in groups
          csv.flush
          puts "Created #{i+1} Messages"
        end
      end
      csv.flush
    end
  end
end
