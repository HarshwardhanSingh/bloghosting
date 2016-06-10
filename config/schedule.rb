env :PATH, ENV['PATH']
env :GEM_PATH, ENV['GEM_PATH']
set :output, "/home/odd/cron_log.log"
set :bundle_command, "/usr/local/bin/bundle"
set :environment, 'development' 

every 1.minute do
	runner "Post.updateRank"
end

# every 1.minute do
# 	runner "Notification.checkNotifications"
# end