import 'package:counter/counter_app/counter_app.dart' as counter_app;
import 'package:flutter_appkit/flutter_appkit.dart' as appkit;

void main() {
  appkit.appRun((locale) => counter_app.CounterApp(locale: locale), observeRiverPod: false);
}
