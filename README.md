[![pub package](https://img.shields.io/pub/v/flutter_dyscan.svg)](https://pub.dartlang.org/packages/flutter_dyscan)

DyScan allows users on your mobile app to add their payment information more easily.

## Setup

<details>
<summary>Android</summary>

This plugin requires several changes to be able to work on Android devices. Please make sure you follow all these steps:

1. Use Android 5.0 (API level 21) and above
2. Use Kotlin version 1.5.0 and above

The easiest way to integrate DyScan is by using our Nexus repository, which is covered in this guide.

In the project-level `build.gradle` add the Dyneti Maven repository (credentials provided during integration):

```gradle
allprojects {
    repositories {
        // Other repositories are here
        maven {
            credentials  {
                username = "nexusUsername"
                password = "nexusPassword"
            }
            url "https://nexus.dyneti.com/repository/maven-releases/"
            authentication {
                basic(BasicAuthentication)
            }
        }
    }
}
```

**Camera features support**

By default, DyScan uses `uses-feature` tags in its `AndroidManifest.xml` file to filter out devices that don't support the required camera features. This filtering affects the host app's supported device count in Google Play.
You can override this filtering by adding the below lines into your `AndroidManifest.xml` manifest tag section:

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools">
    ...
    <uses-permission android:name="android.permission.CAMERA" />

    <uses-feature android:name="android.hardware.camera" android:required="false" tools:replace="required" />
    <uses-feature android:name="android.hardware.camera.autofocus" android:required="false" tools:replace="required" />

    ...
</manifest>
```

</details>

<details>
<summary>iOS</summary>

Compatible with apps targeting iOS 13 or above.

To upgrade your iOS deployment target to `13.0`, you can either do so in Xcode under your Build Settings, or by modifying `IPHONEOS_DEPLOYMENT_TARGET` in your project.pbxproj directly.

You will also need to update in your Podfile:

```ruby
platform :ios, '13.0'
```


1. Add the following to your `Info.plist` file:

```plist
<key>NSCameraUsageDescription</key>
<string>To capture credit card details please grant camera access</string>
```

2. Follow the instructions below corresponding with your DyScan version to access the necessary repositories.

After getting the access token for Dyneti's repo access, open up your `Podfile` and above the target add this line:

```ruby
target 'Runner' do
  use_frameworks!
  use_modular_headers!
    
  # Add this line
  source 'https://dyscan@github.com/dyneti/dyscan-podspec.git'

end
```

Later when asked for a password for user "dyscan", paste the access token that provided by DyScan.

</details>

## Dart API

The library offers several methods to handle DyScan related actions:

```dart
Future<void> init(...);
Future<CardScanResult> startCardScan(...);
```

## Run the example app

- Navigate to the example folder `cd dyscan_example`
- Install the dependencies
  - `flutter pub get`
- Run the project
  - `flutter run`

## Contributing & Donate

You can help us make this project better, feel free to open an new issue or a pull request.

If you found this project helpful or you learned something from the source code and want to thank me, consider buying me a cup of coffee

<a href="https://www.buymeacoffee.com/vvvirani"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" height="80"></a>

<a href="https://www.paypal.com/vvvirani"><img src="https://www.edigitalagency.com.au/wp-content/uploads/new-PayPal-Logo-horizontal-full-color-png.png" height="75"></a>

## Author

This `FlutterDyScan` plugin for Flutter is developed by [V Developer](https://github.com/vvvirani). You can contact us at <vvvirani@gmail.com>
