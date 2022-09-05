# Mauricio Martinez Marques - Posterr
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

#### How to use Posterr

1. Selecting the user

* Go to the `PosterrAppConfig.plist` file and under the `USERS` dictionary, set to `YES` the `IS_LOGGED` property of the user you want to use.
[Selecting_the_user.mp4](videos/Selecting_the_user.mp4)

2. Creating and interacting with posts
[How_to_use_Posterr.mp4](videos/How_to_use_Posterr.mp4)

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

* Check for coverage Slather report at [./fastlane/slather_coverage/index.html](./fastlane/slather_coverage/index.html)

#### Critique (missing points)

* Improve UI style, colors, fonts and icons
* Add app icon image
* Add Launch screen
* Add loading states for the services request
* Abstract some router and presenter behaviors to base implementations, in order to achieve more reusability
* Add more UI test cases changing the users
* Add pre-commit routine to run tests