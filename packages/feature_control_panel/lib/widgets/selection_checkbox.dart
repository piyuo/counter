// TOC:
//  - SelectionCheckbox: reusable iOS-like adaptive checkbox

import 'package:flutter/material.dart';

class SelectionCheckbox extends StatelessWidget {
  const SelectionCheckbox({
    required this.value,
    required this.onChanged,
    this.tristate = false,
    this.size = 28,
    super.key,
  });

  final bool? value;
  final ValueChanged<bool?>? onChanged;
  final bool tristate;
  final double size;

  static const _baseVisualSize = 18.0;

  @override
  Widget build(BuildContext context) {
    final scale = (size / _baseVisualSize).clamp(1.0, 2.0);
    return SizedBox(
      width: size,
      height: size,
      child: Theme(
        data: Theme.of(context).copyWith(
          checkboxTheme: CheckboxThemeData(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
            side: BorderSide(color: Colors.grey),
          ),
        ),
        child: Center(
          child: Transform.scale(
            scale: scale,
            child: Checkbox.adaptive(
              value: value,
              tristate: tristate,
              onChanged: onChanged,
              activeColor: Colors.blue,
              checkColor: Colors.white,
              materialTapTargetSize: MaterialTapTargetSize.padded,
              visualDensity: VisualDensity.standard,
            ),
          ),
        ),
      ),
    );
  }
}
