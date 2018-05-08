# Maintaining

Travis is set up to run once every 24 hours. The script in `.travis.yml` clones the latest `master` of HyperDEX and publishes a new nightly build.

You can force a new build immediately with: `git commit --amend --no-edit && git push --force-with-lease`. Can be useful if it's important to get out a build right away.

## Setup

- Add a environment variable to Travis named `GH_TOKEN` with a [GitHub personal access token](https://github.com/settings/tokens/new) with the `public_repo` scope.
- Add a environment variable to Travis named `EP_PRE_RELEASE` to `true`.
- Add a new Travis cron job that runs every day.
