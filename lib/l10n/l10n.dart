import 'package:flutter/widgets.dart';

import 'app_localization.dart';

extension L10nExtension on BuildContext {
  AppLocalization get l => AppLocalization.of(this);
}
