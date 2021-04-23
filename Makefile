PROJECT_NAME := $(shell basename `pwd`)

include Makefile.d/utils/diagram_makers.mk
include Makefile.d/utils/linter_fixers.mk
include Makefile.d/utils/system_utils.mk
include Makefile.d/utils/updaters.mk
include Makefile.d/utils/local_ssl_config.mk
include Makefile.d/utils/prod_ssl_config.mk
include Makefile.d/utils/sitemap.mk

include Makefile.d/shared/rm.mk
include Makefile.d/shared/rm_internal_volumes_and_networks.mk
include Makefile.d/shared/build.mk
include Makefile.d/shared/drop_db.mk
include Makefile.d/shared/recreate_db.mk
include Makefile.d/shared/migrate_db.mk

include Makefile.d/feature_tests/default.mk

include Makefile.d/dev/default.mk

include Makefile.d/dev_with_prod_db/default.mk

include Makefile.d/tdd/default.mk

include Makefile.d/unit_tests/default.mk

include Makefile.d/prod/db.mk
include Makefile.d/prod/postgres.mk
include Makefile.d/prod/setup.mk
include Makefile.d/prod/up.mk
include Makefile.d/prod/restart.mk
include Makefile.d/prod/redis.mk
include Makefile.d/prod/utils.mk
