# Posterr
---
#### Environment Setup

1. Install `Xcode` version `13.1 (Recommended)`
2. Install and set `ruby` version `3.0.2`, using a ruby version manager tool, like [rvm](https://rvm.io/) or [rbenv](https://github.com/rbenv/rbenv)
3. Install `Bundler` version `2.2.22 (Recommended)`
```
gem install bundler
```
4. Install project's ruby dependencies running 
```
bundle install
```
5. Install CocoaPods dependencies
```
bundle exec pod install
```

#### Running tests

##### Unit tests
```
bunde exec fastlane run_unittests
```

Snapshot tests at `./PosterrTests/Common/Helpers/__Snapshots__` and `./PosterrTests/Scenes/__Snapshots__`

##### UI tests
```
bunde exec fastlane run_UItests
```

##### All tests (Unit and UI)
```
bunde exec fastlane run_all_tests
```

* Check for coverage Slather report at `./fastlane/slather_coverage/index.html`