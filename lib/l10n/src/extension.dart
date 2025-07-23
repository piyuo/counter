import 'package:flutter/widgets.dart';

import 'localization.dart';

extension L10nExtension on BuildContext {
  Localization get l => Localization.of(this);
}
