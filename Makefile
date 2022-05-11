# Must have `sentry-cli` installed globally
# Following variable must be passed in
#  SENTRY_AUTH_TOKEN
# SENTRY_* properties are set in the local ./.env file

ifneq (,$(wildcard ./.env))
    include .env
    export
endif

setup_release: create_release associate_commits upload_sourcemaps

create_release:
	sentry-cli releases -o $(SENTRY_ORG) new -p $(SENTRY_PROJECT) $(VERSION)

associate_commits:
	sentry-cli releases -o $(SENTRY_ORG) -p $(SENTRY_PROJECT) set-commits --auto $(VERSION)

upload_sourcemaps:
	sentry-cli releases -o $(SENTRY_ORG) -p $(SENTRY_PROJECT) files $(VERSION) \
		upload-sourcemaps --url-prefix "~/js" --validate dist/js
