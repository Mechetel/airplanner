prod_redis_purge_cache:
	export REDIS_HOST=MYAPP-live-redis.uqjinu.ng.0001.usw2.cache.amazonaws.com && \
	export REDIS_PORT=6379 && \
	redis-cli -h $$REDIS_HOST -p $$REDIS_PORT --raw keys cache* | xargs redis-cli -h $$REDIS_HOST -p $$REDIS_PORT del

# removes sidekiq tasks
# prod_redis_purge_all:
# 	export REDIS_HOST=MYAPP-live-redis.uqjinu.ng.0001.usw2.cache.amazonaws.com && \
# 	export REDIS_PORT=6379 && \
# 	redis-cli -h $$REDIS_HOST -p $$REDIS_PORT --raw flushall
