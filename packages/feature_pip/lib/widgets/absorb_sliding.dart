import 'package:flutter/cupertino.dart';

bool pipAbsorbSliding = false;

class AbsorbSliding extends StatelessWidget {
  const AbsorbSliding({
    required this.child,
    super.key,
  });

  /// the child
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) {
        pipAbsorbSliding = true;
      },
      onPointerUp: (_) {
        pipAbsorbSliding = false;
      },
      child: child,
    );
  }
}
