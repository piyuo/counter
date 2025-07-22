# Counter - AI-Powered Pedestrian Counter

An intelligent mobile application that uses AI to automatically count pedestrians through your phone's camera. Perfect for monitoring foot traffic without manual intervention.

## Features

- **AI-Powered Recognition**: Advanced computer vision technology for accurate pedestrian detection
- **Automatic Counting**: No manual input required - just point and count
- **Offline Operation**: Works without internet connection
- **Real-time Processing**: Instant pedestrian detection and counting
- **Cross-Platform**: Available on iOS, Android, and Windows

## Use Cases

- Retail foot traffic analysis
- Event attendance monitoring
- Public space usage statistics
- Research and urban planning
- Security and crowd management

## Download

| Platform | Download Link                                                         |
| -------- | --------------------------------------------------------------------- |
| iOS      | [App Store](https://apps.apple.com/app/piyuo-counter/id6743642606)    |
| Android  | [Google Play](https://groups.google.com/g/piyuo-counter-beta-testers) |
| Windows  | [Microsoft Store](https://apps.microsoft.com/detail/9nz6vcxrjjzd)     |

Visit [piyuo.com](https://piyuo.com) for direct download links.

## How It Works

1. Open the app and point your camera at the area to monitor
2. The AI automatically detects and counts passing pedestrians
3. View real-time count statistics on your screen
4. Export or save counting data as needed

## Technology

Built with Flutter for cross-platform compatibility and powered by advanced machine learning models for accurate pedestrian detection.

## Requirements

- Camera-enabled device
- Minimum OS versions:
  - iOS 11.0+
  - Android 6.0+
  - Windows 10+

### 🏃 Running Tests

**Primary Method - Flutter Command Line**:

**AI Agents should use the Flutter command line for running tests** as it's more stable and reliable than IDE plugins:

```bash
# Run all tests in the project
flutter test

# Run tests with coverage report
flutter test --coverage

# Run tests in verbose mode
flutter test --verbose

# Run specific test file
flutter test test/path/to/specific_test.dart

# Run tests with custom reporter for better output
flutter test --reporter expanded

# Run tests and watch for changes
flutter test --watch

# Run tests with specific name pattern
flutter test --name "test_pattern"
```

**Why Command Line Over IDE Plugins**:

- **Stability**: Command line tools are more stable and less prone to hanging
- **Consistency**: Same behavior across different development environments
- **Performance**: Faster execution without IDE overhead
- **Debugging**: Clear error messages and stack traces in terminal
- **CI/CD Ready**: Same commands work in continuous integration pipelines

**Alternative Method - VS Code Flutter Test Plugin**:
While the VS Code Flutter test plugin provides UI integration, it can be unstable and may hang during execution. Use it only if you specifically need the visual test runner interface, but be prepared to fall back to command line when issues occur.

## 🌍 Localization (i18n)

l10n provides a streamlined localization system that supports 70+ languages and locales. All translations are managed through a single CSV file for easy maintenance and collaboration.

### 📁 File Structure

```bash
/lib
    /l10n
      l10n.csv          # Master translation file (edit this)
      *.arb             # Generated ARB files (do not edit)
      *.dart            # Generated Dart files (do not edit)
```

### 🔧 How It Works

1. **Central Translation File**: All translations are stored in `/lib/src/l10n/l10n.csv`
2. **CSV Format**: Standard CSV with key column and locale columns
3. **Automatic Generation**: Script converts CSV to Flutter ARB format and generates Dart code

### 📝 CSV Structure

The `l10n.csv` file follows this format:

```csv
Key,app_af,app_am,app_ar,app_en,app_es,app_fr,app_de,app_ja,app_ko,app_zh,...
back,Terug,ተመለስ,رجوع,Back,Atrás,Retour,Zurück,戻る,뒤로,返回,...
save,Stoor,አስቀምጥ,حفظ,Save,Guardar,Sauvegarder,Speichern,保存,저장,保存,...
```

**Column Format**:

- `Key`: Translation key used in your Dart code
- `app_[locale]`: Translation for specific locale (e.g., `app_en` for English, `app_zh_CN` for Chinese Simplified)

### 🛠️ Adding/Updating Translations

1. **Edit the CSV file**: Open `/lib/src/l10n/l10n.csv` in any text editor or spreadsheet application
2. **Add new keys**: Add new rows with translation key and values for each locale
3. **Update existing translations**: Modify existing values in the CSV
4. **Generate Flutter files**: Run the convert script

```bash
# build_translation will Convert CSV to ARB and generate Dart files
./scripts/build_translation.sh
```

> **⚠️ CRITICAL: CSV Comma Escaping**
>
> When adding or updating translations in the CSV file, **always escape commas properly**:
>
> - **Text containing commas MUST be wrapped in double quotes**: `"Hello, world"`
> - **Double quotes within text must be escaped with double quotes**: `"She said ""Hello"""`
> - **Failure to escape commas will cause column misalignment and build errors**
>
> **Examples**:
>
> ```csv
> Key,app_en,app_es,app_fr
> greeting,"Hello, welcome!","¡Hola, bienvenido!","Bonjour, bienvenue!"
> quote_example,"She said ""Hello""","Ella dijo ""Hola""","Elle a dit ""Bonjour"""
> ```

This script:

- Converts `l10n.csv` to standard Flutter ARB files
- Automatically runs `flutter gen-l10n` to generate Dart localization classes
- Creates ready-to-use localization files in your project

### 💻 Usage in Code

After running the generation script, use translations in your Flutter code with the convenient `context.l` extension:

```dart
import 'package:flutter_appkit/l10n/l10n.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(context.l.back),        // Displays "Back" in current locale;
  }
}
```

### 📋 Best Practices

- **Keep keys descriptive**: Use clear, meaningful keys like `login_button` instead of `btn1`
- **Use CSV tools**: Edit the CSV in spreadsheet applications for easier management
- **⚠️ ALWAYS escape commas**: Wrap text containing commas in double quotes to prevent column misalignment
- **Test translations**: Verify translations in context, especially for RTL languages
- **Consistent terminology**: Maintain consistent terminology across all locales
- **Handle pluralization**: Use ICU message format for complex pluralization rules when needed

### 🔄 Workflow for Teams

1. **Developers**: Add new translation keys to CSV with English values
2. **Translators**: Fill in translations for their assigned locales
3. **Build Process**: Run `./scripts/build_translation.sh` to generate files
4. **Version Control**: Commit both CSV and generated files to ensure consistency

### 🚨 Important Notes

- **Never edit generated files**: Only modify `l10n.csv` directly
- **⚠️ ALWAYS escape commas in CSV**: Text containing commas must be wrapped in double quotes (`"Hello, world!"`) to prevent build errors
- **Run script after changes**: Always run the generation script after CSV updates
- **Commit generated files**: Include generated `.arb` and `.dart` files in version control
- **Test thoroughly**: Test your app in different locales to ensure proper display and functionality

## 🧰 Tech Stack

- **Flutter (Stable Channel, e.g., 3.x.x)**: Core UI framework for cross-platform mobile, web, and desktop development.
- **Riverpod / Provider**: For simple and scalable state management. We use Provider in our legacy code but are migrating to Riverpod.
- **Mockito**: For creating mock objects in tests.
- **flutter_lints**: Recommended set of lints for Flutter projects to enforce best practices and code consistency.
- **Firebase**: A comprehensive mobile and web application development platform by Google.
  - **Crashlytics**: For real-time crash reporting and insightful analytics to help prioritize and fix stability issues.
  - **Cloud Messaging (FCM)**: For sending notifications across platforms.

## 🛠️ Development Tools

These tools support local development, collaboration, and testing:

- **Visual Studio Code** – Recommended code editor with official Flutter and Dart extensions.
- **Flutter SDK** – The software development kit itself, including the Dart SDK, Flutter framework, command-line tools (flutter doctor, flutter run, flutter build), and engine for compiling and running applications across platforms.
- **Git** – Version control for managing source code.
- **GitHub CLI (gh)** – Streamlines GitHub workflows (issues, pull requests, etc.).
- **Android Studio** – Used for advanced Android-specific debugging, emulators, and device management.
- **Xcode** – Essential for iOS development, simulators, device provisioning, and debugging on Apple platforms.
- **Postman** – For API testing and development, crucial when interacting with backend services.

### 📦 Dependency Management

The project includes automated dependency management tools:

- **upgrade_deps.sh** – Automated script that updates all dependencies in `pubspec.yaml` to their latest versions. Run this script to keep your dependencies current without manual intervention:

```bash
./scripts/upgrade_deps.sh
```

## ✅ Best Practices to Follow

These practices guide our development to ensure code quality, maintainability, performance, and scalability:

- We are **migrating from Provider to Riverpod** for improved scalability and testability.
- **Follow the Effective Dart Style Guide**: Adhere to Dart's official style guide for consistent formatting, naming conventions (e.g., `UpperCamelCase` for classes, `lowerCamelCase` for variables), and code structure. This is enforced via `flutter_lints` and `dart format`.
- **Embrace Widget Composition over Inheritance**: Favor composing smaller, reusable widgets to build complex UIs. This leads to cleaner code, better performance, and easier testing compared to deep inheritance hierarchies.
- **Optimize Widget Rebuilds**:
  - **Use `const` constructors whenever possible**: For immutable widgets, using `const` allows Flutter to perform significant optimizations by reusing widget instances and preventing unnecessary rebuilds.
  - **Keep `build` methods pure and lean**: Avoid complex logic, heavy computations, or network calls directly within `build` methods, as they can run frequently. Delegate such operations to state management solutions or lifecycle methods.
  - **Minimize `setState()` scope**: Use `setState()` sparingly and only for the smallest possible widget subtree that needs to update. Prefer robust state management solutions (like Provider, BLoC, Riverpod) for broader or more complex state changes.
- **State Management**: Utilize `Provider` (or your chosen state management solution) for managing application state, ensuring clear separation of concerns between UI and business logic.
  - **Keep state as low as possible**: Place `ChangeNotifier`s or other state objects at the lowest common ancestor in the widget tree to limit the scope of rebuilds.
- **Proper Resource Management**:
  - **Dispose of controllers and streams**: Always `dispose()` of `TextEditingController`, `ScrollController`, `AnimationController`, `StreamSubscription`s, and similar resources when the corresponding `StatefulWidget` is unmounted (`@override void dispose() { super.dispose(); }`). This prevents memory leaks.
  - **Handle asynchronous operations safely**: Always check `mounted` before calling `setState()` after an `await` to prevent errors if the widget is unmounted while the operation is pending.
- **Implement Robust Error Handling**:
  - Use `try-catch` blocks for asynchronous operations (e.g., network requests, file operations).
  - Consider using custom `Exception` classes for application-specific error types.
  - Utilize `flutter_appkit`'s error handling capabilities for consistent error reporting and user feedback.
- **Write Comprehensive Tests**:
  - **Unit Tests**: For business logic, utilities, and individual functions.
  - **Widget Tests**: To verify UI components behave as expected and render correctly.
  - **Integration Tests**: To test interactions between multiple widgets or entire features, simulating user flows.
  - **Strive for good test coverage**: Focus on critical functionalities and edge cases.
- **Implement Responsive and Adaptive UI**: Design UIs that gracefully adapt to different screen sizes, orientations, and device types (mobile, tablet, web, desktop). Leverage `MediaQuery`, `LayoutBuilder`, and `Sliver` widgets.
- **Use Material Design (or Cupertino)**: Adhere to established design guidelines for a consistent and high-quality user experience.
- **Prioritize Performance**:
  - Optimize image assets (e.g., compress, use `CachedNetworkImage` for network images).
  - Employ lazy loading for lists (e.g., `ListView.builder`).
  - Use `SizedBox` or `Sliver` widgets for spacing and layout over overly complex `Container`s when simple sizing is needed.
- **Maintain Clean Code Structure**: Organize code logically into feature-based directories, clearly separating UI, business logic, services, and models.

---

## 🚫 What to Avoid

These are common pitfalls and anti-patterns that can lead to performance issues, bugs, and maintainability challenges:

- **Avoid using the old Provider package** – we are standardizing on Riverpod going forward.
- **Avoid over-reliance on `setState()`**: Do not use `setState()` for global state or for changes that affect large parts of the widget tree. This leads to unnecessary rebuilds and poor performance.
- **Never block the UI thread**: Avoid performing heavy computations, large file I/O, or synchronous network requests directly on the main UI thread. Use `async/await`, `Isolates`, or background services to offload work.
- **Do not hardcode sensitive information**: API keys, sensitive credentials, or environment-specific configurations should *never* be hardcoded into the source code. Use environment variables or secure configuration methods.
- **Avoid excessive nesting (Widget Tree Depth)**: While composition is good, overly deep or convoluted widget trees can become hard to read and debug. Break down complex widgets into smaller, named components.
- **Do not initialize controllers/resources in `build()`**: Avoid creating `AnimationController`, `TextEditingController`, `StreamController`, etc., directly within `build` methods. These should be initialized once in `initState()` and disposed in `dispose()`.
- **Avoid using `print()` for production logging**: `print()` calls can be inefficient and stripped in release builds. Use `debugPrint()` for local debugging or integrate a dedicated logging package (like `logger`) for structured logging that can be controlled by build configurations.
- **Do not ignore `Future`s or `Stream`s**: Ensure all `Future`s are `await`ed or handled with `.then().catchError()`. Similarly, `StreamSubscription`s must be `cancel()`ed. Unhandled futures or streams can lead to unexpected behavior or memory leaks.
- **Avoid global variables for state**: While `GetIt` is a service locator, avoid using simple global variables (`static`) for mutable application state. This makes state harder to track, test, and manage, and can lead to unexpected side effects.
- **Don't ship unused code/assets**: Remove commented-out code, unused imports, and unreferenced assets to keep the bundle size small and the codebase clean.
- **Avoid `as` casts without `is` checks**: Use the `is` operator before casting with `as` to prevent runtime exceptions (e.g., `if (object is MyType) { (object as MyType).doSomething(); }`).

## 📦 Adding a New Module

Since this is a simple library, all source files are organized directly under `/lib/src/` without a module structure. New features should be added as individual files or logical groupings within the source directory.

### 🛠️ How to Add New Features

1. **Create new implementation files** in the `/lib/src/` directory:

   ```bash
   /lib
     /src
       env.dart
       search_impl.dart
       your_new_feature.dart    # ✅ Add new files here
     flutter_appkit.dart
   ```

2. **Expose the public interface** in `flutter_appkit.dart`:

   ```dart
   export 'src/env.dart';
   export 'src/search_impl.dart';
   export 'src/your_new_feature.dart';
   ```

3. **Import the library**:

   ```dart
   import 'package:flutter_appkit/flutter_appkit.dart';
   ```

### ✅ Example

```bash
/lib
  /src
    auth_service.dart
    user_model.dart
    api_client.dart
  flutter_appkit.dart
```

In `flutter_appkit.dart`:

```dart
export 'src/auth_service.dart';
export 'src/user_model.dart';
export 'src/api_client.dart';
```

### 📌 Why This Structure

- **Simplicity**: Flat structure for a focused library
- **Clear public API**: All exports managed in one place
- **Easy maintenance**: No complex module dependencies
- **Scalable**: Can easily reorganize into modules later if needed

## Release Process

### Milestone Completion

When all issues in a milestone are completed:

1. **Release-please creates release PR** automatically
2. **Maintainer reviews and merges** release PR to main
3. **Automatic version bump and changelog** generation
4. **Git tag created** with version number
5. **GitHub Actions deploys to Cloudflare Workers** automatically
6. **Website at <https://piyuo.com> updates immediately**

### 🏃 Running Tests

**Primary Method - Flutter Command Line**:

**AI Agents should use the Flutter command line for running tests** as it's more stable and reliable than IDE plugins:

```bash
# Run all tests in the project
flutter test

# Run tests with coverage report
flutter test --coverage

# Run tests in verbose mode
flutter test --verbose

# Run specific test file
flutter test test/path/to/specific_test.dart

# Run tests with custom reporter for better output
flutter test --reporter expanded

# Run tests and watch for changes
flutter test --watch

# Run tests with specific name pattern
flutter test --name "test_pattern"
```

**Why Command Line Over IDE Plugins**:

- **Stability**: Command line tools are more stable and less prone to hanging
- **Consistency**: Same behavior across different development environments
- **Performance**: Faster execution without IDE overhead
- **Debugging**: Clear error messages and stack traces in terminal
- **CI/CD Ready**: Same commands work in continuous integration pipelines

**Alternative Method - VS Code Flutter Test Plugin**:
While the VS Code Flutter test plugin provides UI integration, it can be unstable and may hang during execution. Use it only if you specifically need the visual test runner interface, but be prepared to fall back to command line when issues occur.

## 🌍 Localization (i18n)

Flutter AppKit provides a streamlined localization system that supports 70+ languages and locales. All translations are managed through a single CSV file for easy maintenance and collaboration.

### 📁 File Structure

```bash
/lib
  /src
    /l10n
      l10n.csv          # Master translation file (edit this)
      *.arb             # Generated ARB files (do not edit)
      *.dart            # Generated Dart files (do not edit)
```

### 🔧 How It Works

1. **Central Translation File**: All translations are stored in `/lib/src/l10n/l10n.csv`
2. **CSV Format**: Standard CSV with key column and locale columns
3. **Automatic Generation**: Script converts CSV to Flutter ARB format and generates Dart code

### 📝 CSV Structure

The `l10n.csv` file follows this format:

```csv
Key,app_af,app_am,app_ar,app_en,app_es,app_fr,app_de,app_ja,app_ko,app_zh,...
back,Terug,ተመለስ,رجوع,Back,Atrás,Retour,Zurück,戻る,뒤로,返回,...
save,Stoor,አስቀምጥ,حفظ,Save,Guardar,Sauvegarder,Speichern,保存,저장,保存,...
```

**Column Format**:

- `Key`: Translation key used in your Dart code
- `app_[locale]`: Translation for specific locale (e.g., `app_en` for English, `app_zh_CN` for Chinese Simplified)

### 🛠️ Adding/Updating Translations

1. **Edit the CSV file**: Open `/lib/src/l10n/l10n.csv` in any text editor or spreadsheet application
2. **Add new keys**: Add new rows with translation key and values for each locale
3. **Update existing translations**: Modify existing values in the CSV
4. **Generate Flutter files**: Run the convert script

```bash
# build_translation will Convert CSV to ARB and generate Dart files
./scripts/build_translation.sh
```

> **⚠️ CRITICAL: CSV Comma Escaping**
>
> When adding or updating translations in the CSV file, **always escape commas properly**:
>
> - **Text containing commas MUST be wrapped in double quotes**: `"Hello, world"`
> - **Double quotes within text must be escaped with double quotes**: `"She said ""Hello"""`
> - **Failure to escape commas will cause column misalignment and build errors**
>
> **Examples**:
>
> ```csv
> Key,app_en,app_es,app_fr
> greeting,"Hello, welcome!","¡Hola, bienvenido!","Bonjour, bienvenue!"
> quote_example,"She said ""Hello""","Ella dijo ""Hola""","Elle a dit ""Bonjour"""
> ```

This script:

- Converts `l10n.csv` to standard Flutter ARB files
- Automatically runs `flutter gen-l10n` to generate Dart localization classes
- Creates ready-to-use localization files in your project

### 💻 Usage in Code

After running the generation script, use translations in your Flutter code with the convenient `context.l` extension:

```dart
import 'package:flutter_appkit/l10n/l10n.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(context.l.back),        // Displays "Back" in current locale;
  }
}
```

### 📋 Best Practices

- **Keep keys descriptive**: Use clear, meaningful keys like `login_button` instead of `btn1`
- **Use CSV tools**: Edit the CSV in spreadsheet applications for easier management
- **⚠️ ALWAYS escape commas**: Wrap text containing commas in double quotes to prevent column misalignment
- **Test translations**: Verify translations in context, especially for RTL languages
- **Consistent terminology**: Maintain consistent terminology across all locales
- **Handle pluralization**: Use ICU message format for complex pluralization rules when needed

### 🔄 Workflow for Teams

1. **Developers**: Add new translation keys to CSV with English values
2. **Translators**: Fill in translations for their assigned locales
3. **Build Process**: Run `./scripts/build_translation.sh` to generate files
4. **Version Control**: Commit both CSV and generated files to ensure consistency

### 🚨 Important Notes

- **Never edit generated files**: Only modify `l10n.csv` directly
- **⚠️ ALWAYS escape commas in CSV**: Text containing commas must be wrapped in double quotes (`"Hello, world!"`) to prevent build errors
- **Run script after changes**: Always run the generation script after CSV updates
- **Commit generated files**: Include generated `.arb` and `.dart` files in version control
- **Test thoroughly**: Test your app in different locales to ensure proper display and functionality

## 🧰 Tech Stack

- **Flutter (Stable Channel, e.g., 3.x.x)**: Core UI framework for cross-platform mobile, web, and desktop development.
- **Riverpod / Provider**: For simple and scalable state management. We use Provider in our legacy code but are migrating to Riverpod.
- **Mockito**: For creating mock objects in tests.
- **flutter_lints**: Recommended set of lints for Flutter projects to enforce best practices and code consistency.
- **Firebase**: A comprehensive mobile and web application development platform by Google.
  - **Crashlytics**: For real-time crash reporting and insightful analytics to help prioritize and fix stability issues.
  - **Cloud Messaging (FCM)**: For sending notifications across platforms.

## 🛠️ Development Tools

These tools support local development, collaboration, and testing:

- **Visual Studio Code** – Recommended code editor with official Flutter and Dart extensions.
- **Flutter SDK** – The software development kit itself, including the Dart SDK, Flutter framework, command-line tools (flutter doctor, flutter run, flutter build), and engine for compiling and running applications across platforms.
- **Git** – Version control for managing source code.
- **GitHub CLI (gh)** – Streamlines GitHub workflows (issues, pull requests, etc.).
- **Android Studio** – Used for advanced Android-specific debugging, emulators, and device management.
- **Xcode** – Essential for iOS development, simulators, device provisioning, and debugging on Apple platforms.
- **Postman** – For API testing and development, crucial when interacting with backend services.

### 📦 Dependency Management

The project includes automated dependency management tools:

- **upgrade_deps.sh** – Automated script that updates all dependencies in `pubspec.yaml` to their latest versions. Run this script to keep your dependencies current without manual intervention:

```bash
./scripts/upgrade_deps.sh
```

## ✅ Best Practices to Follow

These practices guide our development to ensure code quality, maintainability, performance, and scalability:

- We are **migrating from Provider to Riverpod** for improved scalability and testability.
- **Follow the Effective Dart Style Guide**: Adhere to Dart's official style guide for consistent formatting, naming conventions (e.g., `UpperCamelCase` for classes, `lowerCamelCase` for variables), and code structure. This is enforced via `flutter_lints` and `dart format`.
- **Embrace Widget Composition over Inheritance**: Favor composing smaller, reusable widgets to build complex UIs. This leads to cleaner code, better performance, and easier testing compared to deep inheritance hierarchies.
- **Optimize Widget Rebuilds**:
  - **Use `const` constructors whenever possible**: For immutable widgets, using `const` allows Flutter to perform significant optimizations by reusing widget instances and preventing unnecessary rebuilds.
  - **Keep `build` methods pure and lean**: Avoid complex logic, heavy computations, or network calls directly within `build` methods, as they can run frequently. Delegate such operations to state management solutions or lifecycle methods.
  - **Minimize `setState()` scope**: Use `setState()` sparingly and only for the smallest possible widget subtree that needs to update. Prefer robust state management solutions (like Provider, BLoC, Riverpod) for broader or more complex state changes.
- **State Management**: Utilize `Provider` (or your chosen state management solution) for managing application state, ensuring clear separation of concerns between UI and business logic.
  - **Keep state as low as possible**: Place `ChangeNotifier`s or other state objects at the lowest common ancestor in the widget tree to limit the scope of rebuilds.
- **Proper Resource Management**:
  - **Dispose of controllers and streams**: Always `dispose()` of `TextEditingController`, `ScrollController`, `AnimationController`, `StreamSubscription`s, and similar resources when the corresponding `StatefulWidget` is unmounted (`@override void dispose() { super.dispose(); }`). This prevents memory leaks.
  - **Handle asynchronous operations safely**: Always check `mounted` before calling `setState()` after an `await` to prevent errors if the widget is unmounted while the operation is pending.
- **Implement Robust Error Handling**:
  - Use `try-catch` blocks for asynchronous operations (e.g., network requests, file operations).
  - Consider using custom `Exception` classes for application-specific error types.
  - Utilize `flutter_appkit`'s error handling capabilities for consistent error reporting and user feedback.
- **Write Comprehensive Tests**:
  - **Unit Tests**: For business logic, utilities, and individual functions.
  - **Widget Tests**: To verify UI components behave as expected and render correctly.
  - **Integration Tests**: To test interactions between multiple widgets or entire features, simulating user flows.
  - **Strive for good test coverage**: Focus on critical functionalities and edge cases.
- **Implement Responsive and Adaptive UI**: Design UIs that gracefully adapt to different screen sizes, orientations, and device types (mobile, tablet, web, desktop). Leverage `MediaQuery`, `LayoutBuilder`, and `Sliver` widgets.
- **Use Material Design (or Cupertino)**: Adhere to established design guidelines for a consistent and high-quality user experience.
- **Prioritize Performance**:
  - Optimize image assets (e.g., compress, use `CachedNetworkImage` for network images).
  - Employ lazy loading for lists (e.g., `ListView.builder`).
  - Use `SizedBox` or `Sliver` widgets for spacing and layout over overly complex `Container`s when simple sizing is needed.
- **Maintain Clean Code Structure**: Organize code logically into feature-based directories, clearly separating UI, business logic, services, and models.

---

## 🚫 What to Avoid

These are common pitfalls and anti-patterns that can lead to performance issues, bugs, and maintainability challenges:

- **Avoid using the old Provider package** – we are standardizing on Riverpod going forward.
- **Avoid over-reliance on `setState()`**: Do not use `setState()` for global state or for changes that affect large parts of the widget tree. This leads to unnecessary rebuilds and poor performance.
- **Never block the UI thread**: Avoid performing heavy computations, large file I/O, or synchronous network requests directly on the main UI thread. Use `async/await`, `Isolates`, or background services to offload work.
- **Do not hardcode sensitive information**: API keys, sensitive credentials, or environment-specific configurations should *never* be hardcoded into the source code. Use environment variables or secure configuration methods.
- **Avoid excessive nesting (Widget Tree Depth)**: While composition is good, overly deep or convoluted widget trees can become hard to read and debug. Break down complex widgets into smaller, named components.
- **Do not initialize controllers/resources in `build()`**: Avoid creating `AnimationController`, `TextEditingController`, `StreamController`, etc., directly within `build` methods. These should be initialized once in `initState()` and disposed in `dispose()`.
- **Avoid using `print()` for production logging**: `print()` calls can be inefficient and stripped in release builds. Use `debugPrint()` for local debugging or integrate a dedicated logging package (like `logger`) for structured logging that can be controlled by build configurations.
- **Do not ignore `Future`s or `Stream`s**: Ensure all `Future`s are `await`ed or handled with `.then().catchError()`. Similarly, `StreamSubscription`s must be `cancel()`ed. Unhandled futures or streams can lead to unexpected behavior or memory leaks.
- **Avoid global variables for state**: While `GetIt` is a service locator, avoid using simple global variables (`static`) for mutable application state. This makes state harder to track, test, and manage, and can lead to unexpected side effects.
- **Don't ship unused code/assets**: Remove commented-out code, unused imports, and unreferenced assets to keep the bundle size small and the codebase clean.
- **Avoid `as` casts without `is` checks**: Use the `is` operator before casting with `as` to prevent runtime exceptions (e.g., `if (object is MyType) { (object as MyType).doSomething(); }`).

## 📦 Adding a New Module

Since this is a simple library, all source files are organized directly under `/lib/src/` without a module structure. New features should be added as individual files or logical groupings within the source directory.

### 🛠️ How to Add New Features

1. **Create new implementation files** in the `/lib/src/` directory:

   ```bash
   /lib
     /src
       env.dart
       search_impl.dart
       your_new_feature.dart    # ✅ Add new files here
     flutter_appkit.dart
   ```

2. **Expose the public interface** in `flutter_appkit.dart`:

   ```dart
   export 'src/env.dart';
   export 'src/search_impl.dart';
   export 'src/your_new_feature.dart';
   ```

3. **Import the library**:

   ```dart
   import 'package:flutter_appkit/flutter_appkit.dart';
   ```

### ✅ Example

```bash
/lib
  /src
    auth_service.dart
    user_model.dart
    api_client.dart
  flutter_appkit.dart
```

In `flutter_appkit.dart`:

```dart
export 'src/auth_service.dart';
export 'src/user_model.dart';
export 'src/api_client.dart';
```

### 📌 Why This Structure

- **Simplicity**: Flat structure for a focused library
- **Clear public API**: All exports managed in one place
- **Easy maintenance**: No complex module dependencies
- **Scalable**: Can easily reorganize into modules later if needed

### Release

**Release-please** automatically handles versioning and releases by:

1. **Analyzing commit messages** on the main branch
2. **Determining version type** based on conventional commits:
   - `feat:` commits → Minor version bump (1.1.0 → 1.2.0)
   - `fix:` commits → Patch version bump (1.1.0 → 1.1.1)
   - `feat!:` or `BREAKING CHANGE` → Major version bump (1.1.0 → 2.0.0)
3. **Generating changelog** from commit messages and linked issues
4. **Creating release PR** with version bump and changelog
5. **Creating Git tags** when release PR is merged
6. **Triggering automated deployment** to Cloudflare Workers

### Deployment

Since this project is a Flutter package, merging the release-please PR to create a new version is sufficient. Apps that use this package can update the ref section to get the new version:

```yaml
ref: v2.0.0  # <-- Update this to the new version
```

## Reference Documents

- **/README.md**: Provides a high-level overview of the project, including its purpose and tech stack
- **/CONTRIBUTING.md**: Outlines the complete development workflow for contributing to the project
- **/AGENTS.md**: Provides instructions and goals for AI assistants involved in the project
