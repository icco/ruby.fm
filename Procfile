web: jemalloc.sh bundle exec puma -C config/puma.rb
worker: jemalloc.sh bundle exec sidekiq -i ${DYNO:-1} -c $SIDEKIQ_WORKER_COUNT -t $SIDEKIQ_SHUTDOWN_TIMEOUT -v
