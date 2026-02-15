# App Shell

The `app_shell` directory contains the core orchestration layer of the application. It is responsible for initializing the app, setting up global providers, defining the theme, and handling routing.

## Structure

* **`app_shell.dart`**: The main entry point widget (`AppShell`). It orchestrates the providers, theme, and router to build the application root.
* **`app_providers.dart`**: Contains the `AppProviders` widget, which is responsible for injecting global state management providers (using `Provider`, `Riverpod`, etc.) into the widget tree.
* **`app_router.dart`**: Manages the application's navigation logic. It defines the `onGenerateRoute` callback and handles platform-specific usage (Material vs Cupertino).
* **`app_theme.dart`**: Centralizes the application's theme configuration for both Material and Cupertino design systems.
* **`screens/`**: Contains top-level screens used by the shell, such as the `MainScreen` (fallback or empty state).

## Usage

The `AppShell` widget should be used as the root widget in your `main.dart` (or equivalent entry point):

```dart
void main() {
  runApp(const ProviderScope(child: AppShell()));
}
```

## Responsibilities

* **Orchestration**: Connecting different architectural layers (Data, Domain, Presentation).
* **Lifecycle**: Managing app start-up and tear-down logic.
* **Global Configuration**: Setting up locales, themes, and global keys.
