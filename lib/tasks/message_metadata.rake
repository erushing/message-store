namespace :message_metadata do

  desc "Create CSV file for loading into a database"
  task :create_csv, [:message_count,:filename,:type] => :environment do |t, args|
    require 'csv'
    args.with_defaults(:message_count => 1000,:filename => '/tmp/import_msg_activity.csv',:type => 'activities')
    CSV.open("#{args.filename}", "w") do |csv|
      $j = 1
      args.message_count.to_i.times do |i|
        append = build_metadata(args.type, i)
        append.each do |a|
          csv << a
        end

        if ((i+1) % 10000 == 0)  ### i starts at 0, batch import in groups
          csv.flush
          puts "Created #{i+1} Message #{args.type}"
        end
      end
      csv.flush
    end
  end

  def build_metadata(type, i)
    case type
    when 'activities'
      2.times.collect do
        [
          $j += 1,
          i+1,
          1,
          ["internal_reply", "assignment", "archived"].sample,
          ["blah blah blah", "blah", "blah blah"].sample,
          [1,2,3,4,5,6,7,8,9,10].sample,
          Time.now,
          Time.now
        ]
      end
    when 'assignments'
      1.times.collect do
        [
          i+1,
          i+1,
          1,
          [1,2,3,4,5,6,7,8,9,10].sample,
          ["blah blah blah", "blah", "blah blah"].sample,
          false,
          nil,
          nil,
          Time.now,
          Time.now
        ]
      end
    when 'attachments'
      1.times.collect do
        [
          i+1,
          i+1,
          1,
          ["www.google.com", "www.preview_url.com", "www.fake.com"].sample,
          ["www.google.com", "www.preview_url.com", "www.fake.com"].sample,
          ["photo", "video", "whatever"].sample,
          Time.now,
          Time.now
        ]
      end
    when 'labels'
      5.times.collect do
        [
          $j += 1,
          i+1,
          ["label","other label","positive","negative","neutral","no sentiment","bigly","sad"].sample,
          1,
          Time.now,
          Time.now
        ]
      end
    end
  end

end
