// ===============================================
// Module: invitation_screen.dart
// Description: Invitation code entry screen
//
// Sections:
//   - InvitationScreen widget
// ===============================================
import 'package:feature_pip/feature_pip.dart' as feature_pip;
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class InvitationScreen extends StatefulWidget {
  const InvitationScreen({this.token, super.key});

  final String? token;

  @override
  State<InvitationScreen> createState() => _InvitationScreenState();
}

class _InvitationScreenState extends State<InvitationScreen> {
  static const int _codeLength = 7;
  final List<TextEditingController> _controllers = List.generate(_codeLength, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(_codeLength, (_) => FocusNode());
  bool _submitted = false;

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _handleChanged(int index, String value) {
    final String upper = value.toUpperCase();
    if (upper != value) {
      _controllers[index].text = upper;
      _controllers[index].selection = TextSelection.collapsed(offset: upper.length);
    }

    if (upper.isNotEmpty) {
      if (index < _focusNodes.length - 1) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus();
      }
    } else if (index > 0) {
      _focusNodes[index - 1].requestFocus();
    }

    _trySubmit();
  }

  void _trySubmit() {
    if (_submitted) {
      return;
    }
    final bool isComplete = _controllers.every((controller) => controller.text.trim().length == 1);
    if (!isComplete) {
      return;
    }
    _submitted = true;
    Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final Color borderColor = CupertinoColors.systemGrey4.resolveFrom(context);
    return feature_pip.PipScaffold(
      backgroundColor: CupertinoColors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Enter invitation code',
              textAlign: TextAlign.center,
              style: TextStyle(color: CupertinoColors.systemGreen, fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            Text(
              'Check your email invitation to get the 8-digit code.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14.0, color: CupertinoColors.systemGrey.resolveFrom(context)),
            ),
            const SizedBox(height: 20.0),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 8.0,
              runSpacing: 8.0,
              children: List.generate(
                _codeLength,
                (index) => SizedBox(
                  width: 38.0,
                  child: CupertinoTextField(
                    controller: _controllers[index],
                    focusNode: _focusNodes[index],
                    maxLength: 1,
                    textAlign: TextAlign.center,
                    textCapitalization: TextCapitalization.characters,
                    keyboardType: TextInputType.text,
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[A-Za-z0-9]'))],
                    decoration: BoxDecoration(
                      color: CupertinoColors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: borderColor),
                    ),
                    onChanged: (value) => _handleChanged(index, value),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
