fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## Android

### android build

```sh
[bundle exec] fastlane android build
```

Build the Android application.

### android deploy

```sh
[bundle exec] fastlane android deploy
```

Build and upload to Diawi

### android push

```sh
[bundle exec] fastlane android push
```

Push new versions

### android deploy_prod

```sh
[bundle exec] fastlane android deploy_prod
```

Build and upload apk prod to Diawi

----


## iOS

### ios deploy

```sh
[bundle exec] fastlane ios deploy
```

Deploy app

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
