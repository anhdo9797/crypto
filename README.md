# Crypto Application

The base project flutter flow design patterns [MVVM](https://blog.devgenius.io/flutter-mvvm-architecture-with-provider-a81164ef6da6)

![PreviewApp](preview/app_preview.gif)

## Libraries:

- [provider](https://pub.dev/packages/provider) (state manager)
- [go_router](https://pub.dev/packages/go_router) (navigation)
- [dio](https://pub.dev/packages/dio) (rest api)
- [skeletons](https://pub.dev/packages/skeletons) (more loading)
- ...more libraries

## Features

- Design patterns [MVVM](https://blog.devgenius.io/flutter-mvvm-architecture-with-provider-a81164ef6da6)
- Multiple env (prod/dev)
- Theme config (light/dark mode)
- Multiple language
- Rest api with dio
- Onboard screen
- UI authentication
- Auto deploy [DIAWI](https://www.diawi.com/) using fastlane

## Getting Started

### Step 1:

Download or clone this repo by using the link below:

```dart
git clone https://git@github.com:anhdo9797/cypto.git

cd cypto

```

### Step 2: Config app

#### 1. Change [bundleId, appName](https://medium.com/@vaibhavi.rana99/changing-package-name-android-bundle-identifier-ios-in-flutter-973979f4e6e9)

#### 2. Languages

- Add new file `<lang>.json` inside folder `assets/lang/`
- Add new Language to `supportedLanguages` and locale in `supportLocale` inside file `lib/share/constants/app_language.dart`

#### 3. Launcher_icon, splash

- Replace your logo (dev, production) inside folder `assets/launcher_icon/`
- Run your terminal:

```dart
flutter pub get

/// create icon launcher (read more: https://pub.dev/packages/flutter_launcher_icons)
/// run file flutter_launcher_icons-dev.yaml and flutter_launcher_icons-prod.yaml
flutter pub run flutter_launcher_icons:main -f flutter_launcher_icons*

// create native splash screen (read more: https://pub.dev/packages/flutter_native_splash)
/// generate splash for android prod (change more option in file flutter_native_splash-prod)
flutter pub run flutter_native_splash:create --flavor prod
/// generate splash for android dev (change more option in file flutter_native_splash-dev)
flutter pub run flutter_native_splash:create --flavor dev

/// iOS:
/// replace LauncherImage in Assets.xcassets
```

#### 4. Run debug app

Select environment and run app with [Visual Studio Code](https://docs.flutter.dev/development/tools/vs-code#run-app-in-debug-profile-or-release-mode) or [Android Studio and IntelliJ](https://docs.flutter.dev/development/tools/android-studio#running-and-debugging)

![MultipleEnv](preview/multiple_env.png)

### Step 3: Deploy app

#### 1. [Create an upload keystore](https://docs.flutter.dev/deployment/android#create-an-upload-keystore) in side `android/app`

#### 2. Replace content in file `android/gradle.properties` as file created in step 1

#### 3. Config env inside file `fastlane/.env.dev` and `fastlane/.env.dev` flow: [`DIAWI_TOKEN`](https://github.com/pacification/fastlane-plugin-diawi) [fastlane env](http://docs.fastlane.tools/best-practices/continuous-integration/#environment-variables-to-set)

#### 4. Run your terminal

```dart

// build apk android production
fastlane android build --env prod
// build apk android development
fastlane android build --env dev

// deploy android to diawi
fastlane android deploy --env prod
// -----or---------
fastlane android deploy --env dev

// deploy ios diawi
fastlane ios deploy --env prod
// -----or---------
fastlane ios deploy --env dev

/// read more config: http://docs.fastlane.tools/

```

#### 5. CI/CD with [github action](https://docs.github.com/en/actions) (only android)

- Adding env: `DIAWI_TOKEN` and `EMAIL_CALLBACK` with [secrets for a repository](https://docs.github.com/en/codespaces/managing-codespaces-for-your-organization/managing-encrypted-secrets-for-your-repository-and-organization-for-github-codespaces#adding-secrets-for-a-repository)
- Commit and push to branch main
