## FLUTTER STARTER KIT

This project is licensed under the MIT License - see the [LICENSE](https://opensource.org/licenses/MIT) file for details.

A Flutter Starter Kit using [MVVM](https://medium.com/flutterworld/flutter-mvvm-architecture-f8bed2521958) Design Architecture.

## Getting Started 🚀

This project is a starting point for a Flutter application.

Here are some resources to help you better understand and get started with the Flutter Starter Kit:

- [State Management Package: provider](https://pub.dev/packages/provider)
- [Loading Package: flutter_easyloading](https://pub.dev/packages/flutter_easyloading/versions)
- [Routing Package: go_router](https://pub.dev/packages/go_router)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Project Architecture Pattern (MVVM)

In this project, [MVVM](https://medium.com/flutterworld/flutter-mvvm-architecture-f8bed2521958), aka Model-View-ViewModel is adapted as the base project architecture pattern.

```
├── app
│   ├── model
│   │   ├── ...
│   ├── view
│   │   ├── ...
│   ├── viewmodel
│   │   ├── ...
│   ├── repository
│   │   ├── ...
│   ├── services
│   │   ├── ...
│   ├── assets
│   │   ├── ...
│   ├── utils
│   │   ├── ...
```

### Model

- The model data class defines the format or structure for the data to be utilized.
    ```dart
    class TokenModel {

      TokenModel({this.accessToken, this.refreshToken});

      String? accessToken;
      String? refreshToken;
    }
    ```

### View

- View layer are the presentation layer, where include all the UI classes, eg: Widgets and Pages.

### ViewModel

- ViewModel class as a connector between View and Model, separating View and Model to segregate business logic from UI, by accepting all request from View and perform related request through Model Layer.
- One ViewModel class may serve multiple View classes. (ensuring Extensibility and Maintainability)
- `lib/app/viewmodel/base_view_model.dart` class is provided to unified common action required, eg: notify() and more.
- New ViewModel classes should extends BaseViewModel to inherit the basic unified features included.
    ```dart
    class LoginViewModel extends BaseViewModel {
        Future<void> login(String username, String password) async {
            notify(MyResponse.loading());
            response = await UserRepository().login(username, password);
            notify(response);
        }
    }
    ```

### Repository

- Repository class is defining the business logic for accessing data source, eg: getting data from multiple source and compiled as one data type before passing back to ViewModel.

### Services

- `lib/app/service/base_services.dart` is provided to unified the api request instance, including user authentication

### Assets and Utils

- The `assets` folder contains files related to the app's static resources, such as configuration files, application settings, and any other non-code resources required by the app.
- The `utils` folder contains utility classes or helper functions that provide common functionality used across the app. These utility classes are not tied to a specific feature but are generic tools used in various parts of the app. They help avoid code duplication and improve the maintainability of the project.

## Response Model

The Response model is designed to represent the different states of a network request in a clean and consistent way. It helps manage and encapsulate the data, error, and loading states in a way that can be used throughout the repository and view model layers of your application.

In this model, T represents the type of data returned from a network request (e.g., User, Product, etc.), and V represents the type of error that might be encountered (e.g., String, ErrorModel, etc.).

- data (T?): Holds the data returned from the network request. This is only populated in the COMPLETE state.
- error (V?): Holds the error information if the request failed. This is only populated in the ERROR state.
- status (ResponseStatus): The current status of the request. This can be one of the following:

```dart
enum ResponseStatus { INITIAL, COMPLETE, ERROR, LOADING }
```

## State Management Library

This project relies on [Provider](https://pub.dev/packages/provider) which will be taking the [Flutter App State Management](https://docs.flutter.dev/data-and-backend/state-mgmt/simple) as base reference. Provider is use along with MVVM architectural pattern to provide better separation and management within the project.

Core concepts in Provider:
- [ChangeNotifier](https://api.flutter.dev/flutter/foundation/ChangeNotifier-class.html)
- [Context.read, select, and watch](https://medium.com/@soojlee0701/how-to-use-provider-context-read-watch-and-select-1e41938fdf62)
- [Consumer](https://docs.flutter.dev/data-and-backend/state-mgmt/simple)
- [NotifyListeners](https://api.flutter.dev/flutter/foundation/ChangeNotifier/notifyListeners.html)

### Using the Provider

1. To simplified and standardize the usage of Provider in this project, a base class, base_view_model.dart is provided which extending the ChangeNotifier and include common functions/fields required. (eg: notify() and more)
2. ChangeNotifierProviders are implemented in the top inheritance level of the project (app.dart) which using MultiProvider to support multiple providers within the project.
3. For any new ViewModel class/Provider, please register in the `lib/app/asset/app_options.dart`
```dart
List<SingleChildWidget> providerAssets() => [
  ChangeNotifierProvider.value(value: BaseViewModel()),
  ChangeNotifierProvider.value(value: LocaleViewModel())
];
```
4. To access provider values:
```dart
context.select((ViewModel vm) => vm.properties);
```
5. To access provider without listening for changes:
```dart
context.read<ViewModel>().method()
```

## Configure Routing

This Starter Kit utilizes the [go_router](https://pub.dev/packages/go_router) package to handle routing

Here are some resources to help you better understand and get started with the go_router package:

- [Tutorial: Get Started with go_router](https://www.youtube.com/watch?v=BgcXHA3EHJU&t=519s)

1. Open the `app_router.dart` file and set up `routerConfiguration()` by adding routes in the routes list
2. In the `constants.dart` file, define the NavigateName and NavigatePath constants to configure the GoRoute name and path parameters.
3. Update the page builder's child to display the desired page.
4. Follow tutorial listed above to pass in parameters with go_router package.
5. Follow [Go Router Navigation Doc](https://pub.dev/documentation/go_router/latest/topics/Navigation-topic.html) to navigate between destinations in app.

## Configure Localizations

This Starter Kit relies on [flutter_localizations](https://pub.dev/packages/flutter_localization) and follows the [official internationalization guide for Flutter](https://docs.flutter.dev/ui/accessibility-and-internationalization/internationalization).

Here are some resources to help you better understand and get started with the flutter_localizations package:

- [Tutorial: Get Started with flutter_localizations](https://www.youtube.com/watch?v=YPXbesBx9is)

1. Open the relevant .arb file in the l10n folder, or create a new one for the desired locale.

```
├── l10n
│   ├── arb
│   │   ├── app_en.arb
│   │   └── app_id.arb
```

2. Define the new key/value localization pair, adhering to the required format.
3. Generate updated localization files by running the `flutter gen-l10n` command.
4. Access the localization in the app by using context.l10n.{your localization variable}.

```dart
@override
Widget build(BuildContext context) {
  final l10n = context.l10n;
  return Text(l10n.helloWorld);
}
```

5. For testing different locales, set the locale in `app.dart` by using the Locale('your language code') format.

### Adding Supported Locales

Update the `CFBundleLocalizations` array in the `Info.plist` at `ios/Runner/Info.plist` to include the new locale.

```xml
...

<key>CFBundleLocalizations</key>
<array>
	<string>en</string>
	<string>es</string>
</array>

...
```

## Configure Theme

1. Define the colors in `color_manager.dart`.
2. Set up the theme colors in `theme_manager.dart`.

## Configure Navigation Bar

1. Open the `app_router.dart` file and set up the navigation bar routing according to your preferences in the routes list within the ShellRoute class.

```dart
ShellRoute(
    navigatorKey: _shellNavigatorKey,
    pageBuilder: (context, state, child) {
    return NoTransitionPage(
        child: Navigation(
        location: state.location,
        child: child,
      ),
    );
  },
  routes: [
    // ADD ROUTES HERE
   ],
),
```

2. In the `constants.dart` file, define the NavigateName and NavigatePath constants to configure the GoRoute name and path parameters.
3. Update the page builder's child to display the desired page.
4. Open `navigation.dart` and modify the navBarItems list to add or remove items from the navigation bar.
5. Set the icon, label, and initial location for each navigation bar item.
6. Adjust the navigation bar's styles within the scaffold, set up the logic for the current index and modify the NavigatorRouteItem constant based on the navigation item count.