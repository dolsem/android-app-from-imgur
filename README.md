# From Imgur

A simple application I created to learn Flutter and experiment with Android's custom content providers.

[![Android Version][android-version]][android-url]
[![Android Downloads][android-downloads]][android-url]
[![License: MIT][license-image]][license-url]

## Project Structure

```
├── android/app/src/main/kotlin
│   └── com/dols3m/from_imgur
│       ├── ImgurProvider.kt <- Custom content provider that fetches images from Imgur
│       └── MainActivity.kt <- Android entrypoint
└── lib <- Flutter root
    ├── src
    │   ├── api <- Helper wrappers for working with APIs
    │   ├── cubit <- flutter_bloc state management
    │   ├── extensions <- Dart extensions
    │   ├── models <- Data model definitions
    │   ├── screens <- App screens
    │   ├── widgets <- Reusable widget definitions
    │   ├── app.dart <- Top-most widget with flutter_bloc state injected
    │   └── root_widget.dart <- Navigation and some overlay UI
    └── main.dart <- Flutter entrypoint
```

## Development

```sh
$ flutter pub get # Install dependencies
$ flutter pub run build_runner build --delete-conflicting-outputs  # Generate model serialization helpers
$ flutter build apk --flavor dev # Build the app
```

## Deployment
```sh
$ flutter build appbundle --flavor prod
```

## TODO
- More secure storage solution for Imgur tokens

## License

MIT

[android-url]: https://play.google.com/store/apps/details?id=com.dols3m.from_imgur
[android-version]: https://img.shields.io/endpoint?style=flat-square&color=green&logo=google-play&logoColor=green&url=https%3A%2F%2Fplayshields.herokuapp.com%2Fplay%3Fi%3Dcom.dols3m.from_imgur%26l%3DVersion%26m%3D%24version
[android-downloads]: https://img.shields.io/endpoint?style=flat-square&color=green&logo=google-play&logoColor=green&url=https%3A%2F%2Fplayshields.herokuapp.com%2Fplay%3Fi%3Dcom.dols3m.from_imgur%26l%3DDownloads%26m%3D%24installs
[license-image]: https://img.shields.io/badge/License-MIT-blue.svg?style=flat-square
[license-url]: https://opensource.org/licenses/MIT
