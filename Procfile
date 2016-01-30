web: bundle exec puma -C config/puma.rb
worker: bundle exec sidekiq -i ${DYNO:-1} -c $SIDEKIQ_WORKER_COUNT -t $SIDEKIQ_SHUTDOWN_TIMEOUT -v
